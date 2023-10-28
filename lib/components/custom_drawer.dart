import 'package:flutter/material.dart';
import 'package:my_app/pages/configuracoes/configuracoes_hive.dart';
import 'package:my_app/pages/configuracoes/configuracoes_shared_preferences.dart';
import 'package:my_app/pages/dados_cadastrais/dados_cadastrais_hive.dart';
import 'package:my_app/pages/dados_cadastrais/dados_cadastrais_shared_preferences.dart';
import 'package:my_app/pages/login.dart';
import 'package:my_app/pages/numeros_aleatorios/numeros_aleatorios_hive.dart';
import 'package:my_app/pages/numeros_aleatorios/numeros_aleatorios_shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                context: context,
                builder: (BuildContext bc) {
                  return Wrap(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: const Text('Câmera'),
                        leading: const Icon(Icons.camera),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: const Text('Galeria'),
                        leading: const Icon(Icons.album),
                      ),
                    ],
                  );
                }
              );
            },
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.indigoAccent),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.network('https://hermes.digitalinnovation.one/assets/diome/logo.png'),
              ),
              accountName: const Text('Maycon Douglas'),
              accountEmail: const Text('dev.maycondouglas@gmail.com'),
            ),
          ),
          InkWell(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: const Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 5,),
                  Text('Dados cadastráis'),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DadosCadastrais()
                )
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: const Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 5,),
                  Text('Dados cadastráis - Hive'),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DadosCadastraisHive()
                )
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: const Row(
                children: [
                  Icon(Icons.info),
                  SizedBox(width: 5,),
                  Text('Termos de uso e privacidade'),
                ],
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                context: context,
                builder: (BuildContext bc) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: const Column(
                      children: [
                        Text('Termos de uso e privacidade', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  );
                }
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: const Row(
                children: [
                  Icon(Icons.numbers),
                  SizedBox(width: 5,),
                  Text('Gerador de números'),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext bc) => const NumerosAleatoriosSharedPreferences()));
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: const Row(
                children: [
                  Icon(Icons.numbers),
                  SizedBox(width: 5,),
                  Text('Gerador de números - Hive'),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext bc) => const NumerosAleatoriosHive()));
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: const Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(width: 5,),
                  Text('Configurações'),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext bc) => const ConfiguracoesSharedPreferences()));
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: const Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(width: 5,),
                  Text('Configurações - Hive'),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext bc) => const ConfiguracoesHive()));
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: const Row(
                children: [
                  Icon(Icons.exit_to_app),
                  SizedBox(width: 5,),
                  Text('Sair'),
                ],
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    alignment: Alignment.center,
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    title: const Text('Meu App'),
                    content: const Wrap(
                      children: [
                        Text('Você sairá do aplicativo'),
                        Text('Deseja realmente sair do aplicativo?')
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Não')
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const Login()),
                          );
                        },
                        child: const Text('Sim')
                      )
                    ],
                  );
                }
              );
            },
          )
        ]
      ),
    );
  }
}