import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todocomputacomovel/models/tarefa.dart';

class ItemListaWidget extends StatelessWidget {
  final Tarefa tarefa;
  final Function editarTarefa;
  final Function excluirTarefa;

  ItemListaWidget(
      {Key? key,
      required this.tarefa,
      required this.editarTarefa,
      required this.excluirTarefa})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.only(top: 25, right: 10, bottom: 25, left: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: Text(
                    tarefa.titulo!,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    tarefa.descricao!,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            Container(
              width: 125,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Container(
                      child: IconButton(
                        onPressed: () {
                          editarTarefa(tarefa);
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(right: 5),
                      child: IconButton(
                        onPressed: () {
                          excluirTarefa(tarefa.codigo);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
