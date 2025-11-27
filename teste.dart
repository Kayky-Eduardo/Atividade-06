import 'dart:io';
import 'dart:convert';


Future<void> exibicaoInfoDisciplina(File file, String id_disciplina) async {
  if (!disciplinas.containsKey(id_disciplina)) {
    print("Disciplina não encontrada!");
    return;
  }

  bool continuar = true;
  
  while (continuar) {
    final conteudo = file.readAsStringSync();
    final mapaDecodificado = json.decode(conteudo);
    final List<dynamic> historico = mapaDecodificado['registros_ponto'];
    var qntd = disciplinas[id_disciplina]['quantidade'];

    var registrosDisciplina = historico.where((registro) =>
    registro['id_disciplina'].toString() == id_disciplina).toList();

    if (registrosDisciplina.isEmpty) {
      print("0 Registros encontrados para esta disciplina");
    } else {
      for (var registro in registrosDisciplina) {
        print("ID Info: ${registro['id_info']}");
        print("Aula: ${registro['aula_disciplina']}/$qntd");
        print("Data: ${registro['data']}");
        print("Hora: ${registro['hora']}");
        print("Duração: ${registro['duracao']}");
        
        if (registro.containsKey('presencas')) {
          List<dynamic> presencas = registro['presencas'];
          int presentes = presencas.where((p) => p['presente']).length;
          print("Presentes: $presentes/${presencas.length}");
        }
        
        print("-" * 70);
      }
      int aulaAtual = registrosDisciplina.length;
      print("\nTotal de aulas registradas: $aulaAtual/$qntd");
    }
    
    print("=" * 70);
    stdout.write('1. adicionar novo ponto nesta disciplina\n'
    '2. Ver historico em ponto específico\n3. Voltar\nResposta: ');
    String? inptEscolha = stdin.readLineSync();
    int? escolha = (inptEscolha != null && inptEscolha.isNotEmpty)?
    int.tryParse(inptEscolha) : null;

    if (escolha == 1) {
      DateTime datetime = DateTime.now();
      String data = "${datetime.day}/${datetime.month}/${datetime.year}";
      String hora = "${datetime.hour.toString()}";

      stdout.write("Duração (formato hh:mm): ");
      String? inptDuracao = stdin.readLineSync();

      String? duracao = (inptDuracao != null && inptDuracao.isNotEmpty)?
      inptDuracao.trim() : "01:00";

      int proximoId = historico.isEmpty?
      1 : historico.map((r) => r['id_info'] as int).reduce((a, b) => a > b ? a : b) + 1;

      int proximaAula = registrosDisciplina.length + 1;
      

      print("\nPonto adicionado!");      

    } else if (escolha == 2){
      stdout.write("Digite o id do ponto: ");
      String? inptIdInfo = stdin.readLineSync();
      int? idEscolhido = (inptIdInfo != null && inptIdInfo.isNotEmpty)?
      int.tryParse(inptIdInfo) : null;
      if (idEscolhido != null) {
        menuInfo(file, idEscolhido);
      } else {
        print("ID inválido");
      }
    } else {
      continuar = false;
    }
  }
}

void menuInfo(file, idInfo) async {
  final conteudo = await file.readAsStringSync();
  final mapaDecodificado = json.decode(conteudo);
  final List<dynamic> historico = mapaDecodificado['historico'];
  var registrosHistorico = historico.where((registro) =>
  registro['id_info'].toString() == idInfo).toList();

  if (registrosHistorico.isEmpty) {
      print("0 Registros encontrados para este ponto");
  } else {
    for (var registro in registrosHistorico) {
        print("ID Info: ${registro['nome_aluno']}");
        print("teste");
      }       
      print("-" * 70);
  }
}

int menuPrincipal() {
  print("");
  print("=" * 70);
  print("1 - Lançar frequência (Registrar presença de alunos)");
  print("2 - Ver registros de ponto de uma disciplina");
  print("3 - Ver histórico de alunos");
  print("4 - Sair");
  print("=" * 70);
  
  stdout.write("Escolha uma opção: ");
  String? input = stdin.readLineSync();
  int? opcao = (input != null && input.isNotEmpty) ? int.tryParse(input) : null;
  
  return opcao ?? 999;
}

Future<void> main() async {
  // await inicializarArquivo();
  final file = File("armazenamento.json");
  
  while (true) {
    int opcao = menuPrincipal();
    
    switch (opcao) {
      case 1:
        // await lancarFrequencia(file);
        break;
      case 2:
        int disciplinaId = menuDisciplinas(disciplinas);
        if (disciplinaId != 9999) {
          await exibicaoInfoDisciplina(file, disciplinaId.toString());
        }
        break;
      case 3:
        // mostrarHistorico(file);
        break;
      case 4:
        print("\nEncerrando sistema...");
        return;
      default:
        print("Opção inválida!");
    }
  }
}