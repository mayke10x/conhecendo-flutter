import 'package:my_app/model/card_details.dart';

class CardDetailRepository {
  Future<CardDetailModel> get() async {
    await Future.delayed(const Duration(seconds: 3));
    
    return CardDetailModel(
      1,
      'Meu Card',
      'https://hermes.digitalinnovation.one/assets/diome/logo.png',
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.'
    );
  }
}