import 'package:card_game/model/card_model.dart';
import 'package:card_game/model/heard_info_model.dart';

class PlayerModel {
  final int id;
  final String name;
  var cards = <CardModel>[];
  var heardInfo = <HeardInfoModel>[];

  PlayerModel(this.id, {this.name});
}
