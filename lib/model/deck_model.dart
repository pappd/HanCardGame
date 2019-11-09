import 'package:card_game/model/card_model.dart';
import 'package:card_game/model/card_types_model.dart';

///Representation of the deck
class DeckModel {
  ///Cards in the deck
  final List<CardModel> _cards = [];

  ///Construct a sorted deck with all kind of card type
  ///
  ///Every card type is existing in the deck as many times as it is defined in [cardTypes]
  DeckModel(CardTypesModel cardTypes) {
    for (var colorIndex = 0;
        colorIndex < cardTypes.colors.length;
        colorIndex++) {
      for (var cardValue = 0; cardValue < cardTypes.topValue; cardValue++) {
        for (var i = 0;
            i < cardTypes.distribution[colorIndex][cardValue];
            i++) {
          _cards.add(CardModel(colorIndex: colorIndex, value: cardValue + 1));
        }
      }
    }
  }

  ///Shuffle the [_cards] randomly in the deck
  void shuffle() => _cards.shuffle();

  ///Draw a card from the deck
  ///
  ///Get the last card from the deck
  ///wich is removing from the deck
  CardModel draw() => _cards.isNotEmpty
      ? _cards.removeLast()
      : CardModel(colorIndex: 0, value: -1);

  ///Number of the reaming cards in the deck
  int get length => _cards.length;
}
