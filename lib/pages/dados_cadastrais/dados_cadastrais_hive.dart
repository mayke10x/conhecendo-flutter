import 'package:flutter/material.dart';
import 'package:my_app/components/text_label.dart';
import 'package:my_app/model/dados_cadastrais.dart';
import 'package:my_app/repositories/dados_cadastrais_repository.dart';
import 'package:my_app/repositories/linguagens_repository.dart';
import 'package:my_app/repositories/nivel_repository.dart';

class DadosCadastraisHive extends StatefulWidget {
  const DadosCadastraisHive({super.key});

  @override
  State<DadosCadastraisHive> createState() => _DadosCadastraisHiveState();
}

class _DadosCadastraisHiveState extends State<DadosCadastraisHive> {
  late DadosCadastraisRepository dadosCadastraisRepository;
  DadosCadastraisModel dadosCadastraisModel = DadosCadastraisModel.vazio();

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
    dadosCadastraisRepository = await DadosCadastraisRepository.carregar();
    dadosCadastraisModel = dadosCadastraisRepository.obterDados();

    nomeController.text = dadosCadastraisModel.nome ?? '';
    dataNascimentoController.text = dadosCadastraisModel.dataNascimento == null ? '' : dadosCadastraisModel.dataNascimento.toString();

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
                  dadosCadastraisModel.dataNascimento = data;
                }
              },
            ),
            const SizedBox(height: 10,),
            const TextLabel(texto: 'Nível de experiência'),
            Column(
              children: niveis.map((nivel) => RadioListTile(
                title: Text(nivel.toString()),
                selected: dadosCadastraisModel.nivelExperiencia == nivel,
                value: nivel.toString(),
                groupValue: dadosCadastraisModel.nivelExperiencia,
                onChanged: (value) {
                  setState(() {
                    dadosCadastraisModel.nivelExperiencia = value.toString();
                  });
                }
              )).toList(),
            ),
            const SizedBox(height: 10,),
            const TextLabel(texto: 'Linguagens preferidas'),
            Column(
              children: linguagens.map((linguagem) => CheckboxListTile(
                title: Text(linguagem.toString()),
                value: dadosCadastraisModel.linguagens.contains(linguagem),
                onChanged: (value) {
                  if (value!) {
                    setState(() {
                      dadosCadastraisModel.linguagens.add(linguagem);
                    });
                  } else {
                    setState(() {
                      dadosCadastraisModel.linguagens.remove(linguagem);
                    });
                  }
                },
              )).toList(),
            ),
            const SizedBox(height: 10,),
            const TextLabel(texto: 'Tempo de experiência'),
            DropdownButton(
              value: dadosCadastraisModel.tempoExperiencia,
              isExpanded: true,
              items: returnItens(5),
              onChanged: (value) {
                setState(() {
                  dadosCadastraisModel.tempoExperiencia = int.parse(value.toString());
                });
              },
            ),
            const SizedBox(height: 10,),
            TextLabel(texto: 'Pretenção salarial. R\$ ${dadosCadastraisModel.salario?.round().toString()}'),
            Slider(
              min: 0,
              max: 10000,
              value: dadosCadastraisModel.salario ?? 0,
              onChanged: (double value) {
                setState(() {
                  dadosCadastraisModel.salario = value;
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

                if (dadosCadastraisModel.dataNascimento == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('O Campo data nascimento deve ser preenchido'))
                  );
                  return;
                }

                if (dadosCadastraisModel.nivelExperiencia == null || dadosCadastraisModel.nivelExperiencia!.trim() == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('O campo nível de experiência deve ser preenchido'))
                  );
                  return;
                }

                if (dadosCadastraisModel.linguagens.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('O campo de linguagens preferidas deve ser preenchido'))
                  );
                  return;
                }

                if (dadosCadastraisModel.tempoExperiencia == null || dadosCadastraisModel.tempoExperiencia == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('O campo de tempo de experiência deve ser no mínimo 1'))
                  );
                  return;
                }

                if (dadosCadastraisModel.salario == null || dadosCadastraisModel.salario == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('O Campo de pretenção salarial deve ser maior que 0'))
                  );
                  return;
                }

                dadosCadastraisModel.nome = nomeController.text;
                dadosCadastraisRepository.salvar(dadosCadastraisModel);

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