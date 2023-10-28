import 'package:my_app/model/tarefa.dart';

class TarefaRepository {
  final List<TarefaModel> _tarefas = [];

  Future<void> adicionar(TarefaModel tarefa) async {
    await Future.delayed(const Duration(milliseconds: 500));

    _tarefas.add(tarefa);
  }

  Future<void> alterar(String id, bool concluido) async {
    await Future.delayed(const Duration(milliseconds: 200));

    _tarefas.where((tarefa) => tarefa.id == id).first.concluido = concluido;
  }

  Future<List<TarefaModel>> listarTarefas() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return _tarefas;
  }

  Future<List<TarefaModel>> listarNaoConcluidas() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return _tarefas.where((tarefa) => !tarefa.concluido).toList();
  }

  Future<void> remover(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));

    _tarefas.remove(
      _tarefas.where((tarefa) => tarefa.id == id) .first
    );
  }
}