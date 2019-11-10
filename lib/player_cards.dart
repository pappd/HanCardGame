import 'package:card_game/model/board_model.dart';
import 'package:card_game/model/card_model.dart';
import 'package:flutter/material.dart';
import 'card.dart' as game;
import 'package:flutter_slidable/flutter_slidable.dart';

class PlayerCards extends StatelessWidget {
  final BoardModel board;
  final int playerId;
  final int myId;

  const PlayerCards({Key key, this.myId, this.board, this.playerId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerModel = board.players[playerId];
    final activeId = board.activePlayerId;
    return Slidable(
      enabled:
          board.helpToken > 0 && activeId == myId && myId != playerModel.id,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 1 / board.cardTypes.colors.length,
      actions: <Widget>[
        for (var i = 0; i < board.cardTypes.colors.length; i++)
          IconSlideAction(
            color: board.cardTypes.colors[i],
            icon: Icons.file_upload,
            onTap: () => board.giveInfo(playerId, i),
          ),
      ],
      secondaryActions: <Widget>[
        for (var i = 1; i < board.cardTypes.topValue + 1; i++)
          IconSlideAction(
            iconWidget: Text(
              "$i",
              style: TextStyle(fontSize: 28),
            ),
            color: Colors.grey[i % 2 == 0 ? 50 : 400],
            icon: Icons.file_upload,
            onTap: () => board.giveInfo(playerId, i, color: false),
          ),
      ],
      child: AnimatedContainer(
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
                    myId == playerModel.id
                        ? "Me"
                        : playerModel.name ?? "no name",
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
                            child: board.activePlayerId != myId ||
                                    myId != playerModel.id
                                ? game.Card(
                                    card: playerModel.id == myId
                                        ? board.knownInfo(myId, i).length == 1
                                            ? board.knownInfo(myId, i).first
                                            : null
                                        : playerModel.cards[i],
                                    info: playerModel.heardInfo?.elementAt(i),
                                  )
                                : Dismissible(
                                    direction: DismissDirection.vertical,
                                    key: GlobalKey(),
                                    onDismissed: (direction) => board.put(
                                        playerId, i,
                                        fold:
                                            direction == DismissDirection.down),
                                    background: Container(
                                      alignment: Alignment.topCenter,
                                      color: Colors.red,
                                      child: FittedBox(
                                        child: Text(
                                          "Discard",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 36),
                                        ),
                                      ),
                                    ),
                                    secondaryBackground: Container(
                                      alignment: Alignment.bottomCenter,
                                      color: Colors.red,
                                      child: FittedBox(
                                        child: Text(
                                          "Put",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 36),
                                        ),
                                      ),
                                    ),
                                    child: game.Card(
                                      card: playerModel.id == myId
                                          ? board.knownInfo(myId, i).length == 1
                                              ? board.knownInfo(myId, i).first
                                              : null
                                          : playerModel.cards[i],
                                      info: playerModel.heardInfo?.elementAt(i),
                                    ),
                                  ),
                          ),
                          Flexible(flex: 1, child: SizedBox.expand()),
                        ],
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
