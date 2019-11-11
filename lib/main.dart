import 'package:card_game/model/board_model.dart';
import 'package:card_game/model/card_model.dart';
import 'package:card_game/model/card_types_model.dart';
import 'package:card_game/model/heard_info_model.dart';
import 'package:card_game/model/scored_card_model.dart';
import 'package:card_game/player_cards.dart';
import 'package:card_game/players.dart';
import 'package:flutter/material.dart';
import 'card.dart' as gamee;
import 'table.dart' as game;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BoardModel board;
  @override
  void initState() {
    var types = CardTypesModel(5);
    types.addColor([3, 2, 2, 2, 1]);
    types.addColor([3, 2, 2, 2, 1]);
    types.addColor([3, 2, 2, 2, 1]);
    types.addColor([3, 2, 2, 2, 1]);
    types.addColor([3, 2, 2, 2, 1]);
    board = BoardModel(5, 5, types);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var scoredCardModel = ScoredCardModel(board.cardTypes,
        colorCompleted: () {}, wrongCardWasAdded: () {});
    scoredCardModel.add(CardModel(value: 1, colorIndex: 0));
    //scoredCardModel.add(CardModel(value: 1, colorIndex: 1));
    //scoredCardModel.add(CardModel(value: 1, colorIndex: 2));
    //scoredCardModel.add(CardModel(value: 1, colorIndex: 3));
    //scoredCardModel.add(CardModel(value: 1, colorIndex: 4));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            game.Table(
              scoredCardModel,
              width: 50,
              height: 70,
            ),

            Container(
              width: 390,
              height: 374,
              child: Players(board, 1),
            ),
            // for (var i = 0; i < board.players.length; i++)
            //   PlayerCards(
            //     board: board,
            //     myId: 1,
            //     playerId: i,
            //   ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
