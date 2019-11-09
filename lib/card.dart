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
    return Row(
      children: <Widget>[
        Flexible(
          flex: 4,
          child: Container(
            color: colors[card.colorIndex],
            padding: EdgeInsets.all(5),
            child: FittedBox(
              child: Text(
                "${card.value}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 236,
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
        if ((info?.getValues(true)?.length ?? 0) <
            (info?.possibleValues?.length ?? 0))
          Flexible(
            flex: 1,
            child: Column(
              children: <Widget>[
                for (var c in info.getValues(true))
                  Expanded(
                    child: FittedBox(
                      child: Text(
                        "${c + 1}",
                        style: TextStyle(
                          backgroundColor: Colors.grey[700],
                          color: Colors.white,
                          fontSize: 36,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
      ],
    );
  }
}
