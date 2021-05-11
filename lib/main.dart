import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:yolo/CreateGameScreen.dart';
import 'package:yolo/JoinGameScreen.dart';
import 'package:yolo/MainScreen.dart';

void main() {
  runApp(new MyApp());
  Wakelock.enable();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        accentColor: Colors.white,
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(24.0),
                child: ButtonTheme(
                    height: 60.0,
                    child: new RaisedButton(
                        key: null,
                        onPressed: createGame,
                        color: Colors.green,
                        child: new Text(
                          "Create Game",
                          style: new TextStyle(
                              fontSize: 16.0,
                              color: const Color(0xFFFFFFFF),
                              fontFamily: "Roboto"),
                        )))),
            SizedBox(height: 16),
            Padding(
                padding: const EdgeInsets.all(24.0),
                child: ButtonTheme(
                    height: 60.0,
                    child: new RaisedButton(
                        key: null,
                        onPressed: joinGame,
                        color: const Color(0xFFe0e0e0),
                        child: new Text(
                          "Join Game",
                          style: new TextStyle(
                              fontSize: 16.0,
                              color: const Color(0xFF000000),
                              fontFamily: "Roboto"),
                        )))),
            Padding(
                padding: const EdgeInsets.all(24.0),
                child: ButtonTheme(
                    height: 60.0,
                    child: new RaisedButton(
                        key: null,
                        onPressed: mainScreen,
                        color: const Color(0xFFe0e0e0),
                        child: new Text(
                          "Main Screen",
                          style: new TextStyle(
                              fontSize: 16.0,
                              color: const Color(0xFF000000),
                              fontFamily: "Roboto"),
                        ))))
          ]),
    );
  }

  void createGame() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateGameScreen()),
    );
  }

  void joinGame() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JoinGameScreen()),
    );
  }

  void mainScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
