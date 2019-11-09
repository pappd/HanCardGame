import 'package:card_game/model/card_types_model.dart';

///Information about card, that players give each other
class HeardInfoModel {
  ///Indices of the possible card color
  final List<bool> possibleColors;

  ///Possible values of the card
  final List<bool> possibleValues;

  ///Constructor of the heard information model
  ///
  ///Initially everything is false becuse right after the drawing
  ///there is no any heard information about the card by the other players
  HeardInfoModel(CardTypesModel cardTypes)
      : possibleColors = [
          for (var i = 0; i < cardTypes.colors.length; i++) false
        ],
        possibleValues = [for (var i = 0; i < cardTypes.topValue; i++) false];

  ///Record the color information, that was said about the card by the other players
  ///
  ///[index] refer to color index
  ///If [isValid] is true the information was said explicitly about the card,
  ///otherwise it is an implicit information
  void heardColor(int index, bool isValid) {
    assert(index < possibleColors.length);
    if (isValid) {
      for (var i = 0; i < possibleColors.length; i++) {
        possibleColors[i] = false;
      }
    }
    possibleColors[index] = isValid;
  }

  ///Record the value information, that was said about the card by the other players
  ///
  ///[index] refer to value index
  ///If [isValid] is true the information was said explicitly about the card,
  ///otherwise it is an implicit information
  void heardValue(int index, bool isValid) {
    assert(index < possibleValues.length);
    if (isValid) {
      for (var i = 0; i < possibleValues.length; i++) {
        possibleValues[i] = false;
      }
    }
    possibleValues[index] = isValid;
  }

  ///Get the indices of non possible colors
  List<int> get nonPossibleColors =>
      List.generate(possibleColors.length, (i) => !possibleColors[i] ? i : -1)
        ..removeWhere((i) => i == -1);

  ///Get the indices of non possible values
  List<int> get nonPossibleValuesIndices =>
      List.generate(possibleValues.length, (i) => !possibleValues[i] ? i : -1)
        ..removeWhere((i) => i == -1);
}
