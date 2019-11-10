import 'package:card_game/model/card_model.dart';
import 'package:card_game/model/card_types_model.dart';
import 'package:card_game/model/heard_info_model.dart';
import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  final CardModel card;
  final HeardInfoModel info;
  final List<Color> colors;
  const Card(
      {Key key,
      this.card,
      this.info,
      this.colors = CardTypesModel.defaultColors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 180,
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 4,
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: card == null
                          ? Colors.grey[700]
                          : colors[card.colorIndex],
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 2),
                        right: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          "${card?.value ?? " "}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 236,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if ((info?.getColors(true)?.length ?? 0) <
                    (info?.possibleColors?.length ?? 0))
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        for (var c in info.getColors(true))
                          Expanded(
                            child: Container(
                              color: colors[c],
                            ),
                          )
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if ((info?.getValues(true)?.length ?? 0) <
              (info?.possibleValues?.length ?? 0))
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.grey[700],
                child: Row(
                  children: <Widget>[
                    for (var c in info.getValues(true))
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            "${c + 1}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 136,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
