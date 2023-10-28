import 'package:flutter/material.dart';
import 'package:my_app/services/app_storage.dart';

class ConfiguracoesSharedPreferences extends StatefulWidget {
  const ConfiguracoesSharedPreferences({super.key});

  @override
  State<ConfiguracoesSharedPreferences> createState() => _ConfiguracoesSharedPreferencesState();
}

class _ConfiguracoesSharedPreferencesState extends State<ConfiguracoesSharedPreferences> {
  AppStorage storage = AppStorage();

  var nomeUsuarioController = TextEditingController(text: '');
  var alturaController = TextEditingController(text: '');

  bool receberNotificacoes = false;
  bool temaEscuro = false;

  @override
  void initState() {
    super.initState();

    carregarDados();
  }

  void carregarDados() async {
    nomeUsuarioController.text = await storage.getConfiguracoesNome();
    alturaController.text = (await storage.getConfiguracoesAltura()).toString();
    receberNotificacoes = await storage.getConfiguracoesReceberNotificacoes();
    temaEscuro = await storage.getConfiguracoesTemaEscuro();
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Configurações'),
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
                value: receberNotificacoes,
                onChanged: (bool value) {
                  setState(() {
                    receberNotificacoes = value;
                  });
                }
              ),
              SwitchListTile(
                title: const Text('Tema escuro'),
                value: temaEscuro,
                onChanged: (bool value) {
                  setState(() {
                    temaEscuro = value;
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

                  await storage.setConfiguracoesNome(nomeUsuarioController.text);
                  await storage.setConfiguracoesAltura(double.parse(alturaController.text));
                  await storage.setConfiguracoesReceberNotificacoes(receberNotificacoes);
                  await storage.setConfiguracoesTemaEscuro(temaEscuro);
                  
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