import 'package:flutter/material.dart';
import 'package:my_app/components/custom_drawer.dart';
import 'package:my_app/pages/card_page.dart';
import 'package:my_app/pages/list_view_horizontal.dart';
import 'package:my_app/pages/tarefa/tarefa_hive.dart';
import 'package:my_app/pages/tarefa/tarefa_sqlite.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController controllerPageView = PageController(initialPage: 0);
  int posicaoPagina = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meu app')
        ),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controllerPageView,
                onPageChanged: (currentPage) {
                  setState(() {
                    posicaoPagina = currentPage;
                  });
                },
                children: [
                  const CardPage(),
                  Column(
                    children: [
                      Image.asset('lib/images/imagem1.png'),
                    ],  
                  ),
                  ListView(
                    children: [
                      ListTile(
                        title: const Text('Usuário 1'),
                        subtitle: const Text('Mostrando uma imagem de capa'),
                        trailing: PopupMenuButton<String>(
                          onSelected: (menu) {

                          },
                          itemBuilder: (BuildContext bc) {
                            return const <PopupMenuEntry<String>>[
                              PopupMenuItem(value: 'opcao1', child: Text('Opção 1')),
                              PopupMenuItem(value: 'opcao2', child: Text('Opção 2')),
                              PopupMenuItem(value: 'opcao3', child: Text('Opção 3')),
                              PopupMenuItem(value: 'opcao4', child: Text('Opção 4')),
                              PopupMenuItem(value: 'opcao5', child: Text('Opção 5')),
                            ];
                          },
                        ),
                        leading: Image.asset('lib/images/imagem1.png'),
                      ),
                      Image.asset('lib/images/imagem1.png'),
                    ],
                  ),
                  const ListViewHorizontal(),
                  const TarefaHive(),
                  const TarefaSQLite(),
                ],
              ),
            ),
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                controllerPageView.jumpToPage(value);
              },
              currentIndex: posicaoPagina,
              items: const [
                BottomNavigationBarItem(label: 'Page 1', icon: Icon(Icons.home)),
                BottomNavigationBarItem(label: 'Page 2', icon: Icon(Icons.add)),
                BottomNavigationBarItem(label: 'Page 3', icon: Icon(Icons.person)),
                BottomNavigationBarItem(label: 'Page 4', icon: Icon(Icons.list)),
                BottomNavigationBarItem(label: 'Tarefas', icon: Icon(Icons.task)),
                BottomNavigationBarItem(label: 'Tarefas SQLite', icon: Icon(Icons.task)),
              ]
            )
          ],
        ),
      );
  }
}