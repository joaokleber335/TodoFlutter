import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todocomputacomovel/core/controllers/tarefa/tarefa_controller.dart';
import 'package:todocomputacomovel/core/repositories/tarefa/tarefa_repository_impl.dart';
import 'package:todocomputacomovel/models/tarefa.dart';
import 'package:todocomputacomovel/pages/cadastro/cadastro_page.dart';
import 'package:todocomputacomovel/pages/home/widgets/item_lista_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TarefaController controller = TarefaController(
    TarefaRepositoryImpl(FirebaseFirestore.instance),
  );

  @override
  void initState() {
    super.initState();
    controller.listarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
      ),
      body: RefreshIndicator(
        child: ValueListenableBuilder(
          builder: (_, __, ___) {
            return ListView.builder(
              padding: EdgeInsets.all(5),
              itemCount: controller.tarefas.value.length,
              itemBuilder: (context, index) => ItemListaWidget(
                tarefa: controller.tarefas.value[index],
                editarTarefa: editarTarefa,
                excluirTarefa: _abreConfirmacaoDialog,
              ),
            );
          },
          valueListenable: controller.tarefas,
        ),
        onRefresh: () {
          return controller.listarTarefas();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Tarefa? tarefa = await Navigator.of(context).push<Tarefa>(
            MaterialPageRoute(builder: (context) {
              return CadastroPage();
            }),
          );
          controller.adicionarTarefa(tarefa!);
        },
      ),
    );
  }

  editarTarefa(Tarefa tarefa) async {
    Tarefa? tarefaEditada = await Navigator.of(context).push<Tarefa>(
      MaterialPageRoute(builder: (context) {
        return CadastroPage(tarefa: tarefa);
      }),
    );
    controller.editarTarefa(tarefaEditada!);
  }

  Future<void> _abreConfirmacaoDialog(String id) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmar exclusão'),
            content: SingleChildScrollView(
              child: Text('Deseja excluir este item permanentemente?'),
            ),
            actions: [
              TextButton(
                child: Text('Não'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Sim'),
                onPressed: () {
                  excluirTarefa(id);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  excluirTarefa(String id) {
    controller.excluirTarefa(id);
  }
}
