import 'dart:io';
import 'dart:convert';

void main() {
  var arquivo = File('armazenamento.json');
  var conteudo = arquivo.readAsStringSync();
  var dados = jsonDecode(conteudo);
  print(dados.keys);
  for (var entry in dados.entries) {
    for (var valor in entry.values) {
      print(valor);
    }
  }
}
