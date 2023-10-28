import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_app/model/dados_cadastrais.dart';
import 'package:my_app/model/tarefa_hive.dart';
import 'package:my_app/my_app.dart';
import 'package:my_app/repositories/sqlite/sqlitedatabase.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var documentsDirectory = await path_provider.getApplicationDocumentsDirectory();
  
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(DadosCadastraisModelAdapter());
  Hive.registerAdapter(TarefaHiveModelAdapter());

  await SQLiteDataBase().iniciarBancoDados();
  
  runApp(const MyApp());
}