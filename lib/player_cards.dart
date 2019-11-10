import 'package:card_game/model/player_model.dart';
import 'package:flutter/material.dart';
import 'card.dart' as game;

class PlayerCards extends StatelessWidget {
  final PlayerModel playerModel;
  final int activeId;
  final int myId;

  const PlayerCards({Key key, this.myId, this.playerModel, this.activeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 100,
      decoration: BoxDecoration(
        color: activeId == playerModel.id
            ? Colors.lightBlueAccent
            : Colors.grey[400],
        border: Border.all(
          width: 3,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text(playerModel.name ?? "no name"),
          ),
          Flexible(
            flex: 10,
            child: Row(
              children: <Widget>[
                for (var i = 0; i < playerModel.cards.length; i++)
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Flexible(flex: 1, child: SizedBox.expand()),
                        Flexible(
                          flex: 20,
                          child: game.Card(
                            card: playerModel.cards[i],
                            info: playerModel.heardInfo?.elementAt(i),
                          ),
                        ),
                        //if (i < playerModel.cards.length - 1)
                        Flexible(flex: 1, child: SizedBox.expand()),
                      ],
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
