import 'dart:math';

import 'package:card_game/model/card_model.dart';
import 'package:card_game/model/card_types_model.dart';
import 'package:card_game/model/deck_model.dart';
import 'package:card_game/model/discarded_cards_model.dart';
import 'package:card_game/model/heard_info_model.dart';
import 'package:card_game/model/player.dart';
import 'package:card_game/model/scored_card_model.dart';

class Board {
  final int playersNumber;
  final int cardsInHandNumber;
  final int maxHelpToken;
  int helpToken;
  int lifeToken;
  final CardTypesModel cardTypes;
  final DeckModel deck;
  final DiscardedCardsModel discardedCards;
  ScoredCardModel scoredCard;
  final List<Player> players;

  var activePlayerId = 0;

  Board(this.playersNumber, this.cardsInHandNumber, this.cardTypes,
      {this.lifeToken = 3, this.maxHelpToken = 10})
      : deck = DeckModel(cardTypes),
        helpToken = maxHelpToken,
        discardedCards = DiscardedCardsModel(cardTypes),
        players = List<Player>.generate(playersNumber, (i) => Player(i)) {
    scoredCard = ScoredCardModel(cardTypes,
        wrongCardWasAdded: loseLife,
        colorCompleted: () => helpToken = min(maxHelpToken, helpToken + 1));
    deck.shuffle();

    //Initial card dealing
    for (var round = 0; round < cardsInHandNumber; round++) {
      for (var player in players) {
        _draw(player.id);
      }
    }
  }

  void _draw(int playerId) {
    players[playerId].cards.add(deck.draw());
    players[playerId].heardInfo.add(HeardInfoModel(cardTypes));
  }

  void put(int playerId, int cardIndex, {bool fold = true}) {
    if (fold) {
      helpToken = min(maxHelpToken, helpToken + 1);
      discardedCards
          .addDisCardedCard(players[playerId].cards.removeAt(cardIndex));
    } else {
      scoredCard.add(players[playerId].cards.removeAt(cardIndex));
    }
    players[playerId].heardInfo.removeAt(cardIndex);

    if (deck.length > 0) {
      _draw(playerId);
    }
    activePlayerId = (activePlayerId + 1) % (playersNumber + 1);
    _isFinished();
  }

  void giveInfo(int playerId, int value, {bool color = true}) {
    if (helpToken < 1) {
      return;
    }
    helpToken--;
    for (var i = 0; i < players[playerId].heardInfo.length; i++) {
      if (color) {
        players[playerId]
            .heardInfo[i]
            .heardColor(value, value == players[playerId].cards[i].colorIndex);
      } else {
        players[playerId]
            .heardInfo[i]
            .heardValue(value, value == players[playerId].cards[i].value);
      }
    }
    activePlayerId = (activePlayerId + 1) % (playersNumber + 1);
    _isFinished();
  }

  List<CardModel> knownInfo(int playerId, int cardIndex) {
    var seenCard = <CardModel>[];
    for (var player in players) {
      if (player.id == playerId) {
        continue;
      }
      seenCard.addAll(player.cards);
    }
    return discardedCards.withMyInfo(
        seenCard, players[playerId].heardInfo[cardIndex]);
  }

  void _isFinished([bool forced = false]) {
    if (forced || (players[activePlayerId].cards.isEmpty && helpToken == 0)) {
      activePlayerId = -1;
    }
  }

  void loseLife() {
    --lifeToken;
    if (lifeToken == 0) {
      _isFinished(true);
    }
  }
}
