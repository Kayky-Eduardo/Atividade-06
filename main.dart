import 'dart:io';
import 'dart:convert';
// Map<String, dynamic> disciplinas = {
//   "id_disciplina": {"nome_disciplina"}
// };

Map<String, dynamic> disciplinas = {
  "1": {"teste"},
  "2": {"teste"},
  "3": {"teste"},
  "4": {"teste"}
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

// Map<String, dynamic> infoDisciplina = {
//   "id_info": {
//   "id_disciplina": id_disciplina,
//   "data": data,
//   "hora": hora,
//   "duracao": duracao,              // sem acento
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

Map<String, dynamic> historico = {"1": {2: 3}, "2": {3: 4}};

void adicionarHistorico(historico) {
  dynamic ultimoID = historico.keys.last;
  dynamic ultimoIdAluno = historico.values.last['id_aluno'];

  ultimoID = int.tryParse(ultimoID)! + 1;
  ultimoIdAluno = int.tryParse(ultimoIdAluno)! + 1;
  print(ultimoID + 1);
  stdout.write('Aluno: ');
  String? inpNomeAluno = stdin.readLineSync();
  String? nomeA = (inpNomeAluno != null && inpNomeAluno.isNotEmpty) ?
  inpNomeAluno.toLowerCase() : null; 
  
  if (nomeA != null) {
      if (!historico.containsValue(nomeA)) {
        historico["${(int.parse(ultimoID)+1).toString()}"] = {"id_aluno": (int.parse(ultimoIdAluno)+1).toString(), "Nome aluno": nomeA};
      }
  } else {
      print("\nVerifique se possui algum campo preenchido de forma incorreta!");
  }
  historico.forEach((chave, valor) => stdout.write("Id info: $chave\nId aluno: $valor['id_aluno']\nNome Aluno: $valor['nome_aluno']\n"));

  
}

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