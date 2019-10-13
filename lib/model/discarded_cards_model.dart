import 'package:card_game/model/card_model.dart';
import 'package:card_game/model/card_types_model.dart';

///Representation of the discarded cards
class DiscardedCardsModel {
  ///Number of each  discarded cards sorted by types
  ///
  ///First index refer to color
  ///second index refer to value
  ///It represents the deficit from the discarded deck
  ///It has non positve values
  final List<List<int>> _cards;

  ///Constract a counter class for discarded cards
  DiscardedCardsModel(CardTypesModel cardTypes)
      : _cards = cardTypes.distribution {
    for (var colorIndex = 0;
        colorIndex < cardTypes.colors.length;
        colorIndex++) {
      for (var cardValue = 1; cardValue < cardTypes.topValue + 1; cardValue++) {
        _cards[colorIndex][cardValue] *= -1;
      }
    }
  }

  ///If a card was discarded by a player,it is moved to this class with this function
  void addDisCardedCard(CardModel card) {
    _cards[card.colorIndex][card.value - 1] += 1;
  }

  ///It is discribe how many piceces of the given car are missing from the deck
  int numberDiscarded(CardModel card) =>
      _cards[card.colorIndex][card.value - 1];

  ///Getter for[_cards]
  List<List<int>> get cardsInDeck => _cards;
}
