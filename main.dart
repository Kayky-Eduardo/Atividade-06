import 'dart:io';
import 'dart:convert';
// Map<String, dynamic> disciplinas = {
//   "id_disciplina": {"nome_disciplina"}
// };

Map<String, String> disciplinas = {
  "UC1": "Analisar requisitos e funcionalidades da aplicação",
  "UC2": "Auxiliar na gestão de projetos de Tecnologia da Informação",
  "UC3": "Desenvolver algoritmos",
  "UC4": "Analisar programação estruturada e orientada a objetos",
  "UC5": "Desenvolver aplicações desktop",
  "UC6": "Criar e manter Banco de Dados",
  "UC7": "Desenvolver aplicações web",
  "UC8": "Desenvolver aplicações mobile",
  "UC9":
      "Realizar operações de atualização e manutenção em aplicações desenvolvidas",
  "UC10": "Realizar testes nas aplicações desenvolvidas",
  "UC11": "Realizar operações de suporte junto ao usuário",
  "UC12": "Projeto Integrador - Desenvolvedor de Aplicações",
};
int menu_disciplinas(disciplinas) {
  disciplinas.forEach((id_disciplina, nome_disciplina) => stdout.write("ID: $id_disciplina Nome: $nome_disciplina\n"));
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

// Map<int, dynamic> infoDisciplina = {
//   0: {
//   "id_disciplina": id_disciplina,
//   "data": data,
//   "hora": hora,
//   "duracao": duracao,
//   "contador" : 0,
//   "aula_disciplina": aula_disciplina}
// };

// Map<String, dynamic> historico = {
//   "id_info": id_info {
//   "id_aluno": id_aluno,
//   "nome_aluno": nome_aluno,
//   "situacao_turma": situacao_turma,
//   "data_de_situacao_da_turma": data_de_situacao_da_turma,
//   "situacao_disciplina": situacao_disciplina,  // corrigido
//   "percentual_frequencia_na_disciplina": percentual_frequencia_na_disciplina,
//   "percentual_frequencia_no_curso": percentual_frequencia_no_curso,
//   "media_de_frequencia_na_disciplina": media_de_frequencia_na_disciplina,
//   "media_final": media_final,
//   "numero_de_faltas_na_disciplina": numero_de_faltas_na_disciplina,
//   "data_hora_turno": data_hora_turno
//  }
// };

Future<void> inicializarArquivo() async {
  final file = File("armazenamento.json");
  if (!await file.exists()) {
    await file.writeAsString(jsonEncode([]));
  }
}

// Future<list<Map, String>>> dados = {}
void main () {
  inicializarArquivo();
}
