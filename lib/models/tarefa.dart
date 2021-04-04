import 'dart:convert';

class Tarefa {
  String? codigo;
  String? titulo;
  String? descricao;
  bool pronta;

  Tarefa({
    this.codigo,
    this.titulo,
    this.descricao,
    this.pronta = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'pronta': pronta,
    };
  }

  factory Tarefa.fromMap(Map<String, dynamic> map, String codigo) {
    return Tarefa(
      codigo: codigo,
      titulo: map['titulo'],
      descricao: map['descricao'],
      pronta: map['pronta'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Tarefa.fromJson(String source, String codigo) => Tarefa.fromMap(json.decode(source), codigo);
}
