import 'package:flutter/cupertino.dart';
import 'package:todocomputacomovel/core/repositories/tarefa/tarefa_repository.dart';
import 'package:todocomputacomovel/models/tarefa.dart';

class TarefaController {
  final TarefaRepository repository;
  final ValueNotifier<List<Tarefa>> tarefas = ValueNotifier([]);

  TarefaController(this.repository);

  adicionarTarefa(Tarefa tarefa) {
    repository.salvar(tarefa);
    listarTarefas();
  }

  editarTarefa(Tarefa tarefa) {
    repository.alterar(tarefa);
    listarTarefas();
  }

  excluirTarefa(String id) {
    repository.excluir(id);
    listarTarefas();
  }

  listarTarefas() async {
    tarefas.value = await repository.listar();
  }
}
