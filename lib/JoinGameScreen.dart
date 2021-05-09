import 'package:flutter/material.dart';

class JoinGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "Game code",
                    hintStyle: TextStyle(fontSize: 20.0),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(24.0),
                child: RaisedButton(
                    key: null,
                    onPressed: enterGame,
                    color: const Color(0xFFe0e0e0),
                    child: new Text(
                      "Enter Game",
                      style: new TextStyle(
                          fontSize: 16.0,
                          color: const Color(0xFF000000),
                          fontFamily: "Roboto"),
                    )))
          ]),
    );
  }

  void enterGame() {}
}
