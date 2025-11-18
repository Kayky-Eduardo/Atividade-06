import 'dart:io';

// Map<String, dynamic> disciplinas = {
//   "id_disciplina": {"nome_disciplina"}
// };

Map<String, dynamic> disciplinas = {
  "1": {"teste"},
  "2": {"teste"},
  "3": {"teste"},
  "4": {"teste"}
};

// Map<String, dynamic> infoDisciplina = {
//   "id_info": {
//   "id_disciplina": id_disciplina,
//   "data": data,
//   "hora": hora,
//   "duracao": duracao,              // sem acento
//   "aula_disciplina": aula_disciplina}
// };

// Map<String, dynamic> historico = {
//   "id_info": id_info,
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
//   "data_hora_turno": data_hora_turno,
// };

Map<String, dynamic> historico = {};

int menu_disciplinas(disciplinas) {
  disciplinas.forEach((id_disciplina, nome_disciplina) => stdout.write("ID: $id_disciplina Nome: $nome_disciplina\n"));
  stdout.write("Digite o id da disciplina: ");

  String? inputO = stdin.readLineSync();
  int? opcao = (inputO != null && inputO.isNotEmpty) ? int.tryParse(inputO) : null;
  print("=" * 70);
  if (opcao != null && !opcao.isNaN) {
    return opcao;
  } else {
    return 9999;
  }
}

void adicionarHistorico(historico) {
  
}


void main () {
  menu_disciplinas(disciplinas);

}