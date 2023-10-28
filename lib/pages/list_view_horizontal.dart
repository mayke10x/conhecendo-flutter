import 'package:flutter/material.dart';

class ListViewHorizontal extends StatefulWidget {
  const ListViewHorizontal({super.key});

  @override
  State<ListViewHorizontal> createState() => _ListViewHorizontalState();
}

class _ListViewHorizontalState extends State<ListViewHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Image.asset('lib/images/imagem1.png'),
                Image.asset('lib/images/imagem1.png'),
                Image.asset('lib/images/imagem1.png'),
                Image.asset('lib/images/imagem1.png'),
              ],
            )
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}