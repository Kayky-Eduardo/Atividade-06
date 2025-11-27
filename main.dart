import 'dart:io';
import 'dart:convert';

Map<String, dynamic> disciplinas = {
  "1": {
    "materia": "Analisar requisitos e funcionalidades da aplicação",
    "quantidade": 20,
  },
  "2": {
    "materia": "Auxiliar na gestão de projetos de Tecnologia da Informação",
    "quantidade": 30,
  },
  "3": {"materia": "Desenvolver algoritmos", "quantidade": 20},
  "4": {
    "materia": "Analisar programação estruturada e orientada a objetos",
    "quantidade": 50,
  },
  "5": {"materia": "Desenvolver aplicações desktop", "quantidade": 20},
  "6": {"materia": "Criar e manter Banco de Dados", "quantidade": 20},
  "7": {"materia": "Desenvolver aplicações web", "quantidade": 20},
  "8": {"materia": "Desenvolver aplicações mobile", "quantidade": 20},
  "9": {
    "materia":
        "Realizar operações de atualização e manutenção em aplicações desenvolvidas",
    "quantidade": 40,
  },
  "10": {
    "materia": "Realizar testes nas aplicações desenvolvidas",
    "quantidade": 15,
  },
  "11": {
    "materia": "Realizar operações de suporte junto ao usuário",
    "quantidade": 60,
  },
  "12": {
    "materia": "Projeto Integrador - Desenvolvedor de Aplicações",
    "quantidade": 100,
  },
};

int menuDisciplinas(disciplinas) {
  disciplinas.forEach(
    (id_disciplina, nome_disciplina) => stdout.write(
      "ID: $id_disciplina\n"
      "Nome: ${nome_disciplina['materia']}\n"
      "Quantidade de Aulas: ${nome_disciplina['quantidade']}\n"
      "\n"
    ), 
  );
  stdout.write("Digite o id da disciplina: ");

  String? inptEscolha = stdin.readLineSync();
  int? opcao = (inptEscolha != null && inptEscolha.isNotEmpty) ? int.tryParse(inptEscolha) : null;
  print("=" * 70);
  if (opcao != null && !opcao.isNaN) {
    return opcao;
  } else {
    return 9999;
  }
}


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
    '2. Ver historico em ponto específico\n3. Ver historico na disciplina'
    '4. Voltar\nResposta: ');
    String? inptEscolha = stdin.readLineSync();
    print("-" * 70);
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
      
      await adicionarInfo(file, proximoId, id_disciplina, data, hora, duracao, proximaAula);

    } else if (escolha == 2){
      continuar = false;
      stdout.write("Digite o id do ponto: ");
      String? inptIdInfo = stdin.readLineSync();
      String? idEscolhido = (inptIdInfo != null && inptIdInfo.isNotEmpty)?
      inptIdInfo.trim() : null;
      if (idEscolhido != null) {
        menuInfo(file, idEscolhido);
      } else {
        print("ID inválido");
      }
    } else if (escolha == 3) {
      print('teste');
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
      registro.forEach((var chave, var valor)=>{
        print("$chave: $valor")
    });
    }
    print("-" * 70);
  }
}

Future<void> adicionarInfo(file, id_info, id_disciplina, data, hora, duracao, aula_disciplina) async {
  String conteudo = await file.readAsString();
  Map<String, dynamic> resposta_json = jsonDecode(conteudo);
  Map<String, dynamic> novoRegistro = {
    "id_info": id_info,
    "id_disciplina": id_disciplina,
    "data": data,
    "hora": hora,
    "duracao": duracao,
    "aula_disciplina": aula_disciplina
  };

    var qntd = disciplinas[id_disciplina]['quantidade'];

    if (aula_disciplina >= qntd) {
      print("Número máximo de pontos nesta disciplina alcançado!\n"
      "Pressione enter para continuar...");
      stdin.readLineSync();
    } else {
      List<dynamic> registrosPonto = resposta_json['registros_ponto'];
      registrosPonto.add(novoRegistro);
      String jsonAtualizado = jsonEncode(resposta_json);
      await file.writeAsString(jsonAtualizado);
      print("\nPonto adicionado!"); 
    }
}

void mostrarHistorico(File file) {
  final conteudo = file.readAsStringSync();
  final mapaDecodificado = json.decode(conteudo);
  final List<dynamic> historico = mapaDecodificado['historico'];
  print("\n" + "=" * 28 + " Alunos " + "=" * 34);
    historico.forEach((registro) {
      if (registro is Map) {
        print("\n" + '=' * 50);
        registro.forEach((chave, valor) {
          if (chave == 'id_aluno' || chave == 'nome_aluno') {
            print('$chave : $valor');
          }
        });
      print('=' * 50);
      } else {
        print(registro);
      }
      print("\n");
    });
}

Future<void> inicializarArquivo() async {
  final file = File("armazenamento.json");
  if (!await file.exists()) {
    Map<String, dynamic> estruturaInicial = {
      "registros_ponto": [],
      "historico": []
    };
    await file.writeAsString(
      jsonEncode(estruturaInicial)
    );
    print("Arquivo json criado!");
  } else {
    return;
  }
}

int menuPrincipal() {
  print("");
  print("=" * 70);
  print("1 - Ver registros de ponto de uma disciplina");
  print("2 - Ver histórico de alunos");
  print("3 - Sair");
  print("=" * 70);
  
  stdout.write("Escolha uma opção: ");
  String? input = stdin.readLineSync();
  int? opcao = (input != null && input.isNotEmpty) ? int.tryParse(input) : null;
  
  return opcao ?? 999;
}
Future<void> main() async {
  await inicializarArquivo();
  final file = File("armazenamento.json");
  
  while (true) {
    int opcao = menuPrincipal();
    
    switch (opcao) {
      case 1:
        int disciplinaId = menuDisciplinas(disciplinas);
        if (disciplinaId != 9999) {
          await exibicaoInfoDisciplina(file, disciplinaId.toString());
        }
        break;
      case 2:
        mostrarHistorico(file);
        break;
      case 3:
        print("\nEncerrando sistema...");
        return;
      default:
        print("Opção inválida!");
    }
  }
}
