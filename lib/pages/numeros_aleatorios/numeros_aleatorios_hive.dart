import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NumerosAleatoriosHive extends StatefulWidget {
  const NumerosAleatoriosHive({super.key});

  @override
  State<NumerosAleatoriosHive> createState() => _NumerosAleatoriosHiveState();
}

class _NumerosAleatoriosHiveState extends State<NumerosAleatoriosHive> {
  late Box boxNumerosAleatorios;

  int? numeroGerado = 0;
  int? qtdClicks = 0;

  @override
  void initState() {
    super.initState();

    carregarDados();
  }

  void carregarDados() async {
    if (Hive.isBoxOpen('box_numeros_aleatorios')) {
      boxNumerosAleatorios = Hive.box('box_numeros_aleatorios');
    } else {
      boxNumerosAleatorios = await Hive.openBox('box_numeros_aleatorios');
    }

    numeroGerado = boxNumerosAleatorios.get('numeroGerado') ?? 0;
    qtdClicks = boxNumerosAleatorios.get('qtdClicks') ?? 0;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Hive - Gerador de Números'),),
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

            boxNumerosAleatorios.put('numeroGerado', numeroGerado!);
            boxNumerosAleatorios.put('qtdClicks', qtdClicks!);
          }
        ),
      ),
    );
  }
}