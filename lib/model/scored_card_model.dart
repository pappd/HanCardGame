import 'package:card_game/model/card_model.dart';
import 'package:card_game/model/card_types_model.dart';

class ScoredCardModel {
  ///Specified colors for index
  final int _numberOfColors;

  ///Highest possible number on the card
  final int _topValue;

  ///Callback function when every cards are on the table with the given color
  ///For example: get a helper token
  final Function colorCompleted;

  ///Callback funtion when the card can not be put down
  ///For example: remove a life token
  final Function wrongCardWasAdded;

  ///Cards on the table, sorted by color
  List<int> _scores;

  ///Construct a container for cards which are on the table
  ///
  ///Card type is necessery to know how many colors are exist
  ScoredCardModel(CardTypesModel cardTypes,
      {this.colorCompleted, this.wrongCardWasAdded})
      : _numberOfColors = cardTypes.colors.length,
        _topValue = cardTypes.topValue {
    assert(colorCompleted != null);
    assert(wrongCardWasAdded != null);
    _scores = List<int>.filled(_numberOfColors, 0);
  }

  ///Try to put down a card
  ///
  ///If it can not then call [wrongCardWasAdded]
  ///If the given color is finished, then call[colorCompleted]
  bool add(CardModel card) {
    if (_scores[card.colorIndex] + 1 == card.value) {
      _scores[card.colorIndex]++;
      if (_scores[card.colorIndex] == _topValue) {
        colorCompleted();
      }
      return true;
    }
    wrongCardWasAdded();
    return false;
  }

  ///Getter for[_scores]
  List<int> get scores => _scores;

  ///Current score of the game
  int get scoreResult => _scores.reduce((a, b) => a + b);
}
