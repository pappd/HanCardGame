import 'dart:math';

import 'package:card_game/card.dart';
import 'package:card_game/model/scored_card_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' as material;

class Table extends StatelessWidget {
  final ScoredCardModel scoredCard;
  final double width;
  final double height;
  final cardWidth;
  final cardHeight;
  final int helpToken;
  final int lifeToken;
  const Table(
    this.scoredCard, {
    Key key,
    this.width = 320,
    this.height = 100,
    this.cardWidth = 60,
    this.cardHeight = 80,
    this.helpToken = 4,
    this.lifeToken = 7,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthLine1Narrow = width * 1.1 / scoredCard.scoredCards.length;
    final double widthLine1 = width * 0.9 / scoredCard.scoredCards.length;
    final double heightLine2Narrow = height * 1.1 / 2;
    final heights = <double>[
      min(widthLine1Narrow / cardWidth * cardHeight, height * 0.8),
      min(widthLine1 / cardWidth * cardHeight, height * 0.8),
      heightLine2Narrow,
    ];

    //There is enough place horizontally for space
    if (widthLine1 > cardWidth || heights[1] >= heights[0]) {
      heights[0] = 0;
    }

    final calculatedCardHeight = scoredCard.scoredCards.length < 4
        ? min(
            width /
                (scoredCard.scoredCards.length + 1) /
                cardWidth *
                cardHeight,
            height)
        : heights.reduce(max);

    final calculatedCardWidth = min(
        calculatedCardHeight / cardHeight * cardWidth,
        2 * width * 0.9 / scoredCard.scoredCards.length);

    if (scoredCard.scoredCards.length < 4) {
      return Container(
        width: width,
        height: height,
        child: Container(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              for (var i = 0; i < scoredCard.scoredCards.length; i++)
                Container(
                    width: calculatedCardWidth,
                    height: calculatedCardHeight,
                    child: Card(card: scoredCard.scoredCards[i])),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: material.Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(200)),
                    ),
                    width: calculatedCardWidth / 2,
                    height: calculatedCardWidth / 2,
                    child: FittedBox(
                        child: Text(
                      "$helpToken",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: material.Colors.white),
                    )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: material.Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(200)),
                    ),
                    width: calculatedCardWidth / 2,
                    height: calculatedCardWidth / 2,
                    child: FittedBox(
                        child: Text(
                      "$lifeToken",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: material.Colors.white),
                    )),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    final double tokenSize = min(
        heights.indexOf(calculatedCardHeight) < 2
            ? (height - calculatedCardHeight) * 0.96
            : scoredCard.scoredCards.length > 5
                ? height * 0.18
                : (width - 2 * calculatedCardWidth) * 0.3,
        calculatedCardHeight * 0.5);

    final tokens = <Widget>[
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          decoration: BoxDecoration(
            color: material.Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(200)),
          ),
          width: tokenSize,
          height: tokenSize,
          child: FittedBox(
              child: Text(
            "$helpToken",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: material.Colors.white),
          )),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          decoration: BoxDecoration(
            color: material.Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(200)),
          ),
          width: tokenSize,
          height: tokenSize,
          child: FittedBox(
              child: Text(
            "$lifeToken",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: material.Colors.white),
          )),
        ),
      ),
    ];

    if (heights.indexOf(calculatedCardHeight) == 0) {
      return Container(
        width: width,
        height: height,
        child: Stack(
          children: <Widget>[
            for (var i = 0; i < scoredCard.scoredCards.length; i++)
              Positioned(
                left: i * calculatedCardWidth * 0.88,
                top: 0,
                child: Container(
                  width: calculatedCardWidth,
                  height: calculatedCardHeight,
                  child: Card(card: scoredCard.scoredCards[i]),
                ),
              ),
            ...tokens,
          ],
        ),
      );
    }

    final cardsOnTop = <Widget>[
      for (var i = 0;
          i <
              scoredCard.scoredCards.length /
                  (heights.indexOf(calculatedCardHeight) < 2 ? 1 : 2);
          i++)
        Container(
            width: calculatedCardWidth,
            height: calculatedCardHeight,
            child: Card(card: scoredCard.scoredCards[i])),
    ];

    final cardsOnBottom = <Widget>[
      if (scoredCard.scoredCards.length - cardsOnTop.length > 2)
        SizedBox(width: 10),
      for (var i = (scoredCard.scoredCards.length /
                  (heights.indexOf(calculatedCardHeight) < 2 ? 1 : 2))
              .ceil();
          i < scoredCard.scoredCards.length;
          i++)
        Container(
            width: calculatedCardWidth,
            height: calculatedCardHeight,
            child: Card(card: scoredCard.scoredCards[i])),
      if (scoredCard.scoredCards.length - cardsOnTop.length > 2)
        SizedBox(width: 10),
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
          ...tokens,
        ],
      ),
    );
  }
}
