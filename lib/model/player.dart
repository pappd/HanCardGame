import 'package:card_game/model/card_model.dart';
import 'package:card_game/model/heard_info_model.dart';

class Player {
  final int id;
  var cards = <CardModel>[];
  var heardInfo = <HeardInfoModel>[];

  Player(this.id);
}
