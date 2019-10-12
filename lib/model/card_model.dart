import 'package:flutter/material.dart';

///Representation of a single card
class CardModel {
  ///Index of the card's color
  final int colorIndex;

  ///Value of the card (Number)
  final int value;

  /// Construct a single card with given [colorIndex] and [value]
  CardModel({
    @required this.colorIndex,
    @required this.value,
  });
}
