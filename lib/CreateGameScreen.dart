import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
                child: QrImage(
              data: "49573223",
              version: QrVersions.auto,
              size: 150.0,
            )),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Here\'s your game QR code:',
                  style: new TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                )),
            SizedBox(height: 16),
            Text(
              '49573223',
              style: new TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            Padding(
                padding: const EdgeInsets.all(24.0),
                child: RaisedButton(
                    key: null,
                    onPressed: startGame,
                    color: Colors.green,
                    child: new Text(
                      "Start Game",
                      style: new TextStyle(
                          fontSize: 16.0,
                          color: const Color(0xFFFFFFFF),
                          fontFamily: "Roboto"),
                    )))
          ]),
    );
  }

  void startGame() {}
}
