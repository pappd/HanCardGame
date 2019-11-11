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
      min(widthLine1Narrow / cardWidth * cardHeight, height * 0.8),
      min(widthLine1 / cardWidth * cardHeight, height * 0.8),
      heightLine2Narrow,
    ];

    //There is enough place horizontally for space
    if (widthLine1 > cardWidth || heights[1] >= heights[0]) {
      heights[0] = 0;
    }

    final calculatedCardHeight = heights.reduce(max);
    final calculatedCardWidth = min(
        calculatedCardHeight / cardHeight * cardWidth,
        2 * width * 0.9 / scoredCard.cards.length);

    final double tokenSize = min(
        heights.indexOf(calculatedCardHeight) < 2
            ? (height - calculatedCardHeight) * 0.96
            : scoredCard.cards.length > 5
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
            "4",
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
            "7",
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
            for (var i = 0; i < scoredCard.cards.length; i++)
              Positioned(
                left: i * calculatedCardWidth * 0.88,
                top: 0,
                child: Container(
                  width: calculatedCardWidth,
                  height: calculatedCardHeight,
                  child: Card(card: scoredCard.cards[i]),
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
              scoredCard.cards.length /
                  (heights.indexOf(calculatedCardHeight) < 2 ? 1 : 2);
          i++)
        Container(
            width: calculatedCardWidth,
            height: calculatedCardHeight,
            child: Card(card: scoredCard.cards[i])),
    ];

    final cardsOnBottom = <Widget>[
      if (scoredCard.cards.length - cardsOnTop.length > 2) SizedBox(width: 10),
      for (var i = (scoredCard.cards.length /
                  (heights.indexOf(calculatedCardHeight) < 2 ? 1 : 2))
              .ceil();
          i < scoredCard.cards.length;
          i++)
        Container(
            width: calculatedCardWidth,
            height: calculatedCardHeight,
            child: Card(card: scoredCard.cards[i])),
      if (scoredCard.cards.length - cardsOnTop.length > 2) SizedBox(width: 10),
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
