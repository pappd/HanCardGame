import 'package:card_game/model/board_model.dart';
import 'package:card_game/model/card_model.dart';
import 'package:card_game/model/card_types_model.dart';
import 'package:card_game/model/heard_info_model.dart';
import 'package:card_game/player_cards.dart';
import 'package:flutter/material.dart';
import 'card.dart' as game;

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
  int _counter = 0;
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

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var types = CardTypesModel(5);
    types.addColor([3, 2, 2, 2, 1]);
    types.addColor([3, 2, 2, 2, 1]);
    types.addColor([3, 2, 2, 2, 1]);
    types.addColor([3, 2, 2, 2, 1]);
    types.addColor([3, 2, 2, 2, 1]);
    var info = HeardInfoModel(types);
    board.giveInfo(0, 1);
    //info.heardColor(2, false);
    // info.heardColor(4, false);
    // info.heardColor(1, false);
    // info.heardColor(2, false);
    info.heardColor(1, true);
    info.heardValue(4, false);
    //info.heardValue(3, false);
    info.heardValue(2, false);
    info.heardValue(1, false);
    info.heardValue(0, false);
    info.heardValue(4, false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            Container(
              width: 100,
              height: 140,
              child: game.Card(
                card: CardModel(colorIndex: 1, value: 4),
                info: info,
              ),
            ),
            PlayerCards(
              playerModel: board.players[0],
              myId: 0,
              activeId: 1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
