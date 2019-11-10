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
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.elasticIn,
      width: 390,
      height: 120,
      decoration: BoxDecoration(
        color: activeId == playerModel.id ? Colors.blue : Colors.grey[400],
        border: Border.all(
          width: 3,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Container(
              margin: EdgeInsets.fromLTRB(16, 2, 10, 3),
              child: FittedBox(
                child: Text(
                  myId == playerModel.id ? "Me" : playerModel.name ?? "no name",
                  style: TextStyle(
                      color: activeId == playerModel.id
                          ? Colors.white
                          : Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
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
