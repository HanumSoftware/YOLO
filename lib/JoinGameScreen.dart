import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class JoinGameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => JoinGameScreenState();
}

class JoinGameScreenState extends State<JoinGameScreen> {
  Barcode result;
  QRViewController controller;
  var txt = TextEditingController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            children: <Widget>[
              Expanded(flex: 2, child: _buildQrView(context)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(
                            top: 24, left: 24, right: 24, bottom: 8),
                        child: Text(
                          'Scan the barcode or insert the game code manually',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        )),
                    Container(
                        margin: EdgeInsets.only(
                            top: 24, left: 24, right: 24, bottom: 8),
                        child: TextField(
                            controller: txt,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              hintText: "Game code",
                            ))),
                    Container(
                        margin: EdgeInsets.only(top: 24, left: 24, right: 24),
                        width: double.infinity,
                        child: RaisedButton(
                            onPressed: startGame,
                            color: Colors.green,
                            child: new Text(
                              "Start Game",
                              style: new TextStyle(
                                  fontSize: 16.0,
                                  color: const Color(0xFFFFFFFF),
                                  fontFamily: "Roboto"),
                            )))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void startGame() {}

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        if (scanData.code.isNotEmpty && isNumeric(scanData.code)) {
          txt.text = scanData.code;
        }
      });
    });
  }

  bool isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void enterGame() {}
}
