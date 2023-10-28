import 'package:flutter/material.dart';
import 'package:my_app/model/card_details.dart';
import 'package:my_app/pages/card_detail.dart';
import 'package:my_app/repositories/card_detail_repository.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  CardDetailModel? cardDetail;
  var cardDetailRepository = CardDetailRepository();

  @override
  void initState() {
    super.initState();

    carregarDados();
  }

  void carregarDados() async {
    cardDetail = await cardDetailRepository.get();
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            width: double.infinity,
            child: cardDetail == null
            ? const LinearProgressIndicator()
            :InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardDetail(cardDetail: cardDetail!,)
                  )
                );
              },
              child: Hero(
                tag: cardDetail!.id,
                child: Card(
                  elevation: 8,
                  child: Padding( 
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              cardDetail!.url,
                              height: 20,
                            ),
                            Text(cardDetail!.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          cardDetail!.text,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('Ler Mais', style: TextStyle(decoration: TextDecoration.underline),),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
  }
}