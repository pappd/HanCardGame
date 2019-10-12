import 'package:card_game/model/card_model.dart';

///Representation of the deck
class DeckModel {
  ///Definition for card types
  ///
  ///First index refer to color
  ///second index refer to value
  final List<List<int>> _cardTypes;

  ///Cards in the deck
  final List<CardModel> _cards = [];

  ///Construct a sorted deck with all kind of [_cardType]
  ///
  ///Every card type is existing in the deck as many times as it is defined in [_cardType]
  DeckModel(this._cardTypes) {
    for (var colorIndex = 0; colorIndex < _cardTypes.length; colorIndex++) {
      for (var cardValue = 1;
          cardValue < _cardTypes[colorIndex].length + 1;
          cardValue++) {
        for (var i = 0; i < _cardTypes[colorIndex][cardValue]; i++) {
          _cards.add(CardModel(colorIndex: colorIndex, value: cardValue));
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
  CardModel draw() => _cards.removeLast();

  ///Number of the reaming cards in the deck
  int get length => _cards.length;
}
