import 'package:flutter/material.dart';

import 'package:todocomputacomovel/core/widgets/generic_text_form_field.dart';
import 'package:todocomputacomovel/models/tarefa.dart';

class CadastroPage extends StatefulWidget {
  late Tarefa? tarefa;

  CadastroPage({this.tarefa});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  late Tarefa _tarefa;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tarefa = (widget.tarefa == null ? Tarefa() : widget.tarefa)!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.tarefa == null
            ? Text('Adicionar nova tarefa')
            : Text('Editar tarefa')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GenericTextFormField(
                  initialValue:
                      widget.tarefa != null ? widget.tarefa!.titulo : '',
                  labelText: 'Título',
                  hintText: 'Nome da tarefa',
                  errorMsg: 'Título é obrigatório',
                  onSaved: (value) => _tarefa.titulo = value,
                  formKey: _formKey,
                ),
                SizedBox(
                  height: 10,
                ),
                GenericTextFormField(
                  initialValue:
                      widget.tarefa != null ? widget.tarefa!.descricao : '',
                  labelText: 'Descrição',
                  hintText: 'Descrição da tarefa',
                  errorMsg: 'Descrição é obrigatório',
                  maxLines: 6,
                  onSaved: (value) => _tarefa.descricao = value,
                  formKey: _formKey,
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: _salvar,
                  child: Text('Salvar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop<Tarefa>(_tarefa);
    }
  }
}
