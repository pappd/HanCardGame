import 'package:card_game/model/card_model.dart';
import 'package:card_game/model/card_types_model.dart';
import 'package:card_game/model/heard_info_model.dart';

///Representation of the discarded cards
class DiscardedCardsModel {
  ///Number of each  discarded cards sorted by types
  ///
  ///First index refer to color
  ///second index refer to value
  final List<List<int>> _cards;

  ///Types of card
  final CardTypesModel cardTypes;

  ///Constract a counter class for discarded cards
  DiscardedCardsModel(this.cardTypes)
      : _cards = [
          for (var i = 0; i < cardTypes.distribution.length; i++)
            [for (var j = 0; j < cardTypes.distribution[i].length; j++) 0]
        ];
  // : _cards = List<List<int>>.filled(cardTypes.distribution.length,
  //       List<int>.filled(cardTypes.distribution[0].length, 0));

  ///If a card was discarded by a player,it is moved to this class with this function
  void addDisCardedCard(CardModel card) {
    _cards[card.colorIndex][card.value - 1] += 1;
  }

  List<CardModel> withMyInfo(List<CardModel> cards, HeardInfoModel heardInfo) {
    var possibleCard = [
      for (var color = 0; color < _cards.length; color++)
        [
          for (var value = 0; value < _cards[color].length; value++)
            cardTypes.distribution[color][value] - _cards[color][value]
        ],
    ];

    for (var card in cards) {
      possibleCard[card.colorIndex][card.value - 1] -= 1;
    }

    for (var c in heardInfo.getColors(false)) {
      for (var i = 0; i < possibleCard[c].length; i++) {
        possibleCard[c][i] = 0;
      }
    }

    for (var v in heardInfo.getValues(false)) {
      for (var c in possibleCard) {
        c[v] = 0;
      }
    }
    var possibleCardList = <CardModel>[];

    for (var color = 0; color < possibleCard.length; color++) {
      for (var value = 1; value < possibleCard[color].length + 1; value++) {
        if (possibleCard[color][value - 1] != 0) {
          possibleCardList.add(CardModel(colorIndex: color, value: value));
        }
      }
    }

    return possibleCardList;
  }

  ///It is discribe how many piceces of the given car are missing from the deck
  int numberDiscarded(CardModel card) =>
      _cards[card.colorIndex][card.value - 1];

  ///Getter for[_cards]
  List<List<int>> get cardsInDeck => _cards;
}
