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

  String? inpO = stdin.readLineSync();
  int? opcao = (inpO != null && inpO.isNotEmpty) ? int.tryParse(inpO) : null;
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
      } else {
        // print(registro);
      }
      print("\n");
    });
    // List<dynamic> listaDeItens = entry.value;
  } catch (e) {
    print('Ocorreu um erro ao decodificar: $e');
  }
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
