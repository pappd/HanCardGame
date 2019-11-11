import 'dart:math';

import 'package:card_game/card.dart';
import 'package:card_game/model/scored_card_model.dart';
import 'package:flutter/widgets.dart';

class Table extends StatelessWidget {
  final ScoredCardModel scoredCard;
  final double width;
  final double height;
  final cardWidth;
  final cardHeight;
  const Table(
    this.scoredCard, {
    Key key,
    this.width = 320,
    this.height = 100,
    this.cardWidth = 60,
    this.cardHeight = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthLine1Narrow = width * 1.1 / scoredCard.cards.length;
    final double widthLine1 = width * 0.9 / scoredCard.cards.length;
    final double heightLine2Narrow = height * 1.1 / 2;
    final heights = <double>[
      min(widthLine1Narrow / cardWidth * cardHeight, height),
      min(widthLine1 / cardWidth * cardHeight, height),
      heightLine2Narrow,
    ];

    //There is enough place horizontally for space
    if (widthLine1 > cardWidth || widthLine1 >= widthLine1Narrow) {
      heights[0] = 0;
    }

    final calculatedCardHeight = heights.reduce(max);
    final calculatedCardWidth = min(
        calculatedCardHeight / cardHeight * cardWidth,
        2 * width * 0.9 / scoredCard.cards.length);

    if (heights.indexOf(calculatedCardHeight) == 0) {
      return Container(
        width: width,
        height: height,
        child: Stack(
          children: <Widget>[
            for (var i = 0; i < scoredCard.cards.length; i++)
              Positioned(
                left: i * calculatedCardWidth * 0.84,
                top: 0,
                child: Container(
                  width: calculatedCardWidth,
                  height: calculatedCardHeight,
                  child: Card(card: scoredCard.cards[i]),
                ),
              )
          ],
        ),
      );
    }

    final cardsOnTop = <Widget>[
      for (var i = 0;
          i <
              scoredCard.cards.length /
                  (heights.indexOf(calculatedCardHeight) < 2 ? 1 : 2);
          i++)
        Container(
            width: calculatedCardWidth,
            height: calculatedCardHeight,
            child: Card(card: scoredCard.cards[i])),
    ];

    final cardsOnBottom = <Widget>[
      for (var i = (scoredCard.cards.length /
                  (heights.indexOf(calculatedCardHeight) < 2 ? 1 : 2))
              .ceil();
          i < scoredCard.cards.length;
          i++)
        Container(
            width: calculatedCardWidth,
            height: calculatedCardHeight,
            child: Card(card: scoredCard.cards[i])),
    ];

    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: cardsOnTop,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: cardsOnBottom,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
