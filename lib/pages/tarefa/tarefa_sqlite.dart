import 'package:flutter/material.dart';
import 'package:my_app/model/tarefa_sqlite_model.dart';
import 'package:my_app/repositories/sqlite/tarefa_sqlite_repository.dart';

class TarefaSQLite extends StatefulWidget {
  const TarefaSQLite({super.key});

  @override
  State<TarefaSQLite> createState() => _TarefaSQLiteState();
}

class _TarefaSQLiteState extends State<TarefaSQLite> {
  TarefaSQLiteRepository tarefaRepository = TarefaSQLiteRepository();
  var _tarefas = <TarefaSQLiteModel>[];

  var descricaoController = TextEditingController();

  bool apenasNaoConcluidos = false;

  @override
  void initState() {
    super.initState();

    obterTarefas();
  }

  void obterTarefas() async {
    _tarefas = await tarefaRepository.obterDados(apenasNaoConcluidos);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          descricaoController.text = '';

          showDialog(
            context: context,
            builder: (BuildContext bc) {
              return AlertDialog(
                title: const Text('Adiconar Tarefa'),
                content: TextField(controller: descricaoController,),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar')
                  ),
                  TextButton(
                    onPressed: () async {
                      await tarefaRepository.salvar(TarefaSQLiteModel(0, descricaoController.text, false));

                      descricaoController.text = '';

                      Navigator.pop(context);

                      obterTarefas();
                    },
                    child: const Text('Salvar')
                  )
                ],
              );
            }
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Apenas não concluídos', style: TextStyle(fontSize: 18),),
                  Switch(
                    value: apenasNaoConcluidos,
                    onChanged: (bool value) {
                      apenasNaoConcluidos = value;
                      obterTarefas();
                    }
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (BuildContext bc, int index) {
                  var tarefa = _tarefas[index];
            
                  return Dismissible(
                    key: Key(tarefa.descricao),
                    onDismissed: (DismissDirection dismissDirection) async {
                      tarefaRepository.remover(tarefa.id);

                      obterTarefas();
                    },
                    child: ListTile(
                      // leading: const Icon(Icons.task),
                      title: Text(tarefa.descricao),
                      trailing: Switch(
                        onChanged: (bool value) async {
                          tarefa.concluido = value;
                          tarefaRepository.atualizar(tarefa);
                              
                          obterTarefas();
                        },
                        value: tarefa.concluido,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}