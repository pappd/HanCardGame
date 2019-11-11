import 'package:card_game/model/board_model.dart';
import 'package:card_game/player_cards.dart';
import 'package:flutter/widgets.dart';

class Players extends StatelessWidget {
  final BoardModel board;
  final int myId;
  const Players(this.board, this.myId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 540,
      child: Column(
        children: <Widget>[
          for (var player in board.players)
            Expanded(
              child: Column(
                children: <Widget>[
                  Flexible(flex: 1, child: SizedBox.expand()),
                  Flexible(
                    flex: 10,
                    child: PlayerCards(
                      board: board,
                      playerId: player.id,
                      myId: myId,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
