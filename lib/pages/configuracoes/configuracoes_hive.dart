import 'package:flutter/material.dart';
import 'package:my_app/model/configuracoes.dart';
import 'package:my_app/repositories/configuracoes_repository.dart';

class ConfiguracoesHive extends StatefulWidget {
  const ConfiguracoesHive({super.key});

  @override
  State<ConfiguracoesHive> createState() => _ConfiguracoesHiveState();
}

class _ConfiguracoesHiveState extends State<ConfiguracoesHive> {
  late ConfiguracoesRepository storage;
  ConfiguracoesModel configuracoesModel = ConfiguracoesModel.vazio();

  var nomeUsuarioController = TextEditingController(text: '');
  var alturaController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();

    carregarDados();
  }

  void carregarDados() async {
    storage = await ConfiguracoesRepository.carregar();
    configuracoesModel = storage.obterDados();

    nomeUsuarioController.text = configuracoesModel.nomeUsuario;
    alturaController.text = configuracoesModel.altura.toString();
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hive - Configurações'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Nome usuário'
                ),
                controller: nomeUsuarioController,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Altura'
                ),
                controller: alturaController,
              ),
              SwitchListTile(
                title: const Text('Receber Notificações'),
                value: configuracoesModel.receberNotificacoes,
                onChanged: (bool value) {
                  setState(() {
                    configuracoesModel.receberNotificacoes = value;
                  });
                }
              ),
              SwitchListTile(
                title: const Text('Tema escuro'),
                value: configuracoesModel.temaEscuro,
                onChanged: (bool value) {
                  setState(() {
                    configuracoesModel.temaEscuro = value;
                  });
                }
              ),
              TextButton(
                child: const Text('Salvar'),
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();

                  try {
                    double.parse(alturaController.text);
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text('Meu App'),
                          content: const Text('Por favor, informar uma altura válida'),
                          actions: [TextButton(
                            onPressed: () { Navigator.pop(context); },
                            child: const Text('Ok')
                          )],
                        );
                      }
                    );

                    return;
                  }

                  configuracoesModel.nomeUsuario = nomeUsuarioController.text;
                  configuracoesModel.altura = double.parse(alturaController.text);

                  storage.salvar(configuracoesModel);
                  
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}