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

int menu_disciplinas(disciplinas) {
  disciplinas.forEach(
    (id_disciplina, nome_disciplina) => stdout.write(
      "ID: $id_disciplina\n"
      "Nome: ${nome_disciplina['materia']}\n"
      "Quantidade de Aulas: ${nome_disciplina['quantidade']}\n"
      "\n",
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

void exibicaoInfoDisciplina(File file, String id_disciplina) {
  final conteudo = file.readAsStringSync();
  final mapaDecodificado = json.decode(conteudo);
  final List<dynamic> historico = mapaDecodificado['registros_ponto'];
  var qntd = disciplinas[id_disciplina]['quantidade'];

  try {
    historico.forEach((registro) {
      if (registro is Map && registro['id_disciplina'].toString() == id_disciplina) {
        registro.forEach((chave, valor) {
          if (chave == 'aula_disciplina') {
            print('$chave : $valor/$qntd');
          } else {
            print('$chave : $valor');
          }
        });
      }
      stdout.write("Deseja adicionar um novo ponto nesta disciplina?(s/n): ");
      String? inptEscolha = stdin.readLineSync();
      String? escolha = (inptEscolha != null && inptEscolha.isNotEmpty) ?
      inptEscolha.trim().toLowerCase() : null;
      if (escolha != null) {
        DateTime datetime = DateTime.now();
        String data = "${datetime.day}/${datetime.month}/${datetime.year}";
        String hora = "${datetime.hour.toString()}";

        stdout.write("Duração(formato h:m)): ");
        String? inptDuracao = stdin.readLineSync();
        String? duracao = (inptDuracao != null && inptDuracao.isNotEmpty) ?
        inptDuracao.trim().toLowerCase() : "01:00";

        // pegar o id info do ultimo e somar mais um
        adicionar_info(id_info, id_disciplina, data, hora, duracao);
      }
    });
  } catch (e) {
    print('Ocorreu um erro ao decodificar: $e');
  }
}

Future<void> adicionar_info(id_info, id_disciplina, data, hora, duracao, [aula_disciplina]) async {
  final file = File("armazenamento.json");
  String conteudo = await file.readAsString();
  // final mapaDecodificado = jsonDecode(conteudo);
  Map<String, dynamic> resposta_json = jsonDecode(conteudo);
  resposta_json['id_info'] = id_info;
  resposta_json['id_disciplina'] = id_disciplina;
  resposta_json['data'] = data;
  resposta_json['hora'] = hora;
  resposta_json['duracao'] = duracao;
  resposta_json['aula_disciplina'] = aula_disciplina ?? '-';

  // List<dynamic>registro_pontos = mapaDecodificado['registros_ponto'][{
  //   "id_info": id_info,
  //   "id_disciplina": id_disciplina,
  //   "data": data,
  //   "hora": hora,
  //   "duracao": duracao,
  //   "aula_disciplina": aula_disciplina
  // }];
  String JSON_atualizado = jsonEncode(resposta_json);
  await file.writeAsString(JSON_atualizado);
}

void mostrarHistorico(File file) {
  final conteudo = file.readAsStringSync();
  final mapaDecodificado = json.decode(conteudo);

  final List<dynamic> historico = mapaDecodificado['historico'];
  try {
    historico.forEach((registro) {
      if (registro is Map) {
        registro.forEach((chave, valor) {
          print('$chave : $valor');
        });
      } else {
        print(registro);
      }
      print("\n");
    });
    // List<dynamic> listaDeItens = entry.value;
  } catch (e) {
    print('Ocorreu um erro ao decodificar: $e');
  }
}

Future<void> inicializarArquivo() async {
  final file = File("armazenamento.json");
  if (!await file.exists()) {
    await file.writeAsString(jsonEncode([]));
  } else {
    return;
  }
}

void relatorioHistorico() async {}

// Future<list<Map, String>>> dados = {}
void main() {
  int opcao = menu_disciplinas(disciplinas);
  final file = File("armazenamento.json");
  exibicaoInfoDisciplina(file, opcao.toString());
  inicializarArquivo();
  // mostrarHistorico(file);
}
