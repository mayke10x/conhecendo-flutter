import 'package:flutter/material.dart';
import 'package:my_app/components/text_label.dart';
import 'package:my_app/repositories/linguagens_repository.dart';
import 'package:my_app/repositories/nivel_repository.dart';
import 'package:my_app/services/app_storage.dart';

class DadosCadastrais extends StatefulWidget {
  const DadosCadastrais({super.key});

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}

class _DadosCadastraisState extends State<DadosCadastrais> {
  AppStorage storage = AppStorage();

  var nomeController = TextEditingController(text: '');
  var dataNascimentoController = TextEditingController(text: '');
  DateTime? dataNascimento;
  
  var nivelRepository = NivelRepository();
  var niveis = [];
  var nivelSelecionado = '';

  var linguagensRepository = LinguagensRepository();
  var linguagens = [];
  List<String> linguagensSelecionadas = [];

  double salarioEscolhido = 0;

  int tempoExperiencia = 0;

  bool salvando = false;

  List<DropdownMenuItem<int>> returnItens(int qtdMax) {
    var itens = <DropdownMenuItem<int>>[];

    for (var i = 0; i < qtdMax; i++) {
      itens.add(DropdownMenuItem(child: Text(i.toString()), value: i));
    }

    return itens;
  }

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();

    carregarDados();
  }

  void carregarDados() async {
    nomeController.text = await storage.getDadosCadastraisNome();
    dataNascimentoController.text = await storage.getDadosCadastraisDataNascimento();
    
    if (dataNascimentoController.text.isNotEmpty) {
      dataNascimento = DateTime.parse(dataNascimentoController.text);
    }

    nivelSelecionado = await storage.getDadosCadastraisNivelExperiencia();
    linguagensSelecionadas = await storage.getDadosCadastraisLinguagens();
    tempoExperiencia = await storage.getDadosCadastraisTempoExperiencia();
    salarioEscolhido = await storage.getDadosCadastraisSalario();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus dados')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: salvando
          ? const Center(child: CircularProgressIndicator())
          : ListView(
          children: [
            const TextLabel(texto: 'Nome'),
            TextField(
              controller: nomeController,
            ),
            const SizedBox(height: 10,),
            const TextLabel(texto: 'Data de nascimento'),
            TextField(
              controller: dataNascimentoController,
              readOnly: true,
              onTap: () async {
                var data = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000, 1, 1),
                  firstDate: DateTime(1900, 5, 20),
                  lastDate: DateTime(2023, 10, 230)
                );

                if (data != null) {
                  dataNascimentoController.text = data.toString();
                  dataNascimento = data;
                }
              },
            ),
            const SizedBox(height: 10,),
            const TextLabel(texto: 'Nível de experiência'),
            Column(
              children: niveis.map((nivel) => RadioListTile(
                title: Text(nivel.toString()),
                selected: nivelSelecionado == nivel,
                value: nivel.toString(),
                groupValue: nivelSelecionado,
                onChanged: (value) {
                  setState(() {
                    nivelSelecionado = value.toString();
                  });
                }
              )).toList(),
            ),
            const SizedBox(height: 10,),
            const TextLabel(texto: 'Linguagens preferidas'),
            Column(
              children: linguagens.map((linguagem) => CheckboxListTile(
                title: Text(linguagem.toString()),
                value: linguagensSelecionadas.contains(linguagem),
                onChanged: (value) {
                  if (value!) {
                    setState(() {
                      linguagensSelecionadas.add(linguagem);
                    });
                  } else {
                    setState(() {
                      linguagensSelecionadas.remove(linguagem);
                    });
                  }
                },
              )).toList(),
            ),
            const SizedBox(height: 10,),
            const TextLabel(texto: 'Tempo de experiência'),
            DropdownButton(
              value: tempoExperiencia,
              isExpanded: true,
              items: returnItens(5),
              onChanged: (value) {
                setState(() {
                  tempoExperiencia = int.parse(value.toString());
                });
              },
            ),
            const SizedBox(height: 10,),
            TextLabel(texto: 'Pretenção salarial. R\$ ${salarioEscolhido.round().toString()}'),
            Slider(
              min: 0,
              max: 10000,
              value: salarioEscolhido,
              onChanged: (double value) {
                setState(() {
                  salarioEscolhido = value;
                });
              },
            ),
            const SizedBox(height: 10,),
            TextButton(
              onPressed: () async {
                if (nomeController.text.trim().length < 3) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('O campo nome deve ser preenchido'))
                  );
                  return;
                }

                if (dataNascimento == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('O Campo data nascimento deve ser preenchido'))
                  );
                  return;
                }

                if (nivelSelecionado.trim() == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('O campo nível de experiência deve ser preenchido'))
                  );
                  return;
                }

                if (linguagensSelecionadas.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('O campo de linguagens preferidas deve ser preenchido'))
                  );
                  return;
                }

                if (tempoExperiencia <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('O campo de tempo de experiência deve ser no mínimo 1'))
                  );
                  return;
                }

                if (salarioEscolhido <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('O Campo de pretenção salarial deve ser maior que 0'))
                  );
                  return;
                }

                await storage.setDadosCadastraisNome(nomeController.text);
                await storage.setDadosCadastraisDataNascimento(dataNascimento!);
                await storage.setDadosCadastraisNivelExperiencia(nivelSelecionado);
                await storage.setDadosCadastraisLinguagens(linguagensSelecionadas);
                await storage.setDadosCadastraisTempoExperiencia(tempoExperiencia);
                await storage.setDadosCadastraisSalario(salarioEscolhido);

                setState(() {
                  salvando = true;
                });

                Future.delayed(const Duration(seconds: 4), () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Dados salvos com sucesso!'))
                  );

                  setState(() {
                    salvando = false;
                  });

                  Navigator.pop(context);
                });
              },
              child: const Text('Salvar'),
            )
          ],
        ),
      )
    );
  }
}