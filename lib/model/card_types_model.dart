import 'package:flutter/material.dart';

///Definition for card types
class CardTypesModel {
  ///Default Colors for index
  static const defaultColors = <Color>[
    Colors.amber,
    Colors.redAccent,
    Colors.blueAccent,
    Colors.green,
    Colors.white,
    Colors.yellowAccent,
    Colors.cyanAccent,
    Colors.yellowAccent,
  ];

  ///Number of each card types
  ///
  ///First index refer to color
  ///second index refer to value
  final List<List<int>> _distribution = [];

  ///Specified colors for index
  final List<Color> _colors = [];

  ///Highest possible number on the card
  final int topValue;

  ///Construct card types
  ///
  ///It is just initializing based on [topValue]
  ///[addColor] is necessery to finish the class
  CardTypesModel(this.topValue);

  ///Add new card type
  ///
  ///For example addColor([5,3,3,1],Colors.Red) means:
  ///Five Red1 card,
  ///Three Red2 card,
  ///Three Red3 card,
  ///One Red4 card
  void addColor(List<int> vmi, {Color color}) {
    assert(vmi.length <= topValue);
    assert(_colors.length < defaultColors.length);
    _distribution.add(vmi);
    _colors.add(color ?? defaultColors[_colors.length]);
  }

  ///Get [_colors]
  List<Color> get colors => _colors;

  ///Get [_distribution]
  List<List<int>> get distribution => _distribution;
}
