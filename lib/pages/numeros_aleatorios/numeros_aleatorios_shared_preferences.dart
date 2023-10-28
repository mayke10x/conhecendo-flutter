import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app/services/app_storage.dart';

class NumerosAleatoriosSharedPreferences extends StatefulWidget {
  const NumerosAleatoriosSharedPreferences({super.key});

  @override
  State<NumerosAleatoriosSharedPreferences> createState() => _NumerosAleatoriosSharedPreferencesState();
}

class _NumerosAleatoriosSharedPreferencesState extends State<NumerosAleatoriosSharedPreferences> {
  AppStorage storageSharedPreferences = AppStorage();

  int? numeroGerado = 0;
  int? qtdClicks = 0;

  @override
  void initState() {
    super.initState();

    carregarDados();
  }

  void carregarDados() async {
    numeroGerado = await storageSharedPreferences.getNumeroAleatorio();
    qtdClicks = await storageSharedPreferences.getQtdClicks();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Gerador de Números Aleatórios'),),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(numeroGerado == null ? 'Nenhum número gerado' : numeroGerado.toString(), style: const TextStyle(fontSize: 24),),
              Text(qtdClicks == null ? 'Nenhum clique realizado' : qtdClicks.toString()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            setState(() {
              numeroGerado = Random().nextInt(1000);
              qtdClicks = qtdClicks == null ? 1 : qtdClicks! + 1;
            });

            await storageSharedPreferences.setNumeroAleatorio(numeroGerado!);
            await storageSharedPreferences.setQtdClicks(qtdClicks!);
          }
        ),
      ),
    );
  }
}