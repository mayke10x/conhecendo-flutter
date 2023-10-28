import 'package:flutter/material.dart';
import 'package:my_app/model/tarefa_hive.dart';
import 'package:my_app/repositories/tarefa_hive_repository.dart';

class TarefaHive extends StatefulWidget {
  const TarefaHive({super.key});

  @override
  State<TarefaHive> createState() => _TarefaHiveState();
}

class _TarefaHiveState extends State<TarefaHive> {
  late TarefaHiveRepository tarefaRepository;
  var _tarefas = <TarefaHiveModel>[];

  var descricaoController = TextEditingController();

  bool apenasNaoConcluidos = false;

  @override
  void initState() {
    super.initState();

    obterTarefas();
  }

  void obterTarefas() async {
    tarefaRepository = await TarefaHiveRepository.carregar();
  
    _tarefas = tarefaRepository.obterDados(apenasNaoConcluidos);

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
                      await tarefaRepository.salvar(TarefaHiveModel.criar(descricaoController.text, false));

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
                    key: Key(tarefa.key.toString()),
                    onDismissed: (DismissDirection dismissDirection) async {
                      tarefaRepository.excluir(tarefa);

                      obterTarefas();
                    },
                    child: ListTile(
                      // leading: const Icon(Icons.task),
                      title: Text(tarefa.descricao),
                      trailing: Switch(
                        onChanged: (bool value) async {
                          tarefa.concluido = value;
                          tarefaRepository.alterar(tarefa);
                              
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