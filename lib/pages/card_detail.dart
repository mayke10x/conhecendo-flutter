import 'package:flutter/material.dart';
import 'package:my_app/model/card_details.dart';

class CardDetail extends StatelessWidget {
  final CardDetailModel cardDetail;

  const CardDetail({super.key, required this.cardDetail});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: cardDetail.id,
      child: SafeArea(
        child: Scaffold(
          body: Padding( 
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
                Row(
                  children: [
                    Image.network(
                      cardDetail.url,
                      height: 100,
                    ),
                  ],
                ),
                Text(cardDetail.title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Expanded(
                  child: Text(
                    cardDetail.text,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}