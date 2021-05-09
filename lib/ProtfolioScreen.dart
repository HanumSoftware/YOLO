import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'AnimatedBackground.dart';
import 'AnimatedWave.dart';

class ProtfolioScreen extends StatelessWidget {
  PanelController pc = new PanelController();

  final europeanCountries = [
    'Albania',
    'Andorra',
    'Armenia',
    'Austria',
    'Azerbaijan',
    'Belarus',
    'Belgium'
  ];

  @override
  Widget build(BuildContext context) {
    Widget firstColumn = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Title',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text('subtitle'),
        ],
      ),
    );

    return SlidingUpPanel(
        controller: pc,
        maxHeight: 200,
        minHeight: 40,
        panel: Column(),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100.0), topRight: Radius.circular(100.0)),
        onPanelOpened: () => {},
        onPanelClosed: () => {},
        body: Stack(
          children: <Widget>[
            Positioned.fill(child: AnimatedBackground()),
            onBottom(AnimatedWave(
              height: 240,
              speed: 1.0,
            )),
            onBottom(AnimatedWave(
              height: 300,
              speed: 0.9,
              offset: pi,
            )),
            onBottom(AnimatedWave(
              height: 340,
              speed: 1.2,
              offset: pi / 2,
            )),
            Container(
                margin: const EdgeInsets.only(top: 48, bottom: 80),
                child: ListView.builder(
                  padding:
                      EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 50),
                  itemCount: europeanCountries == null
                      ? 1
                      : europeanCountries.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return new Container(
                          height: 200,
                          width: 200,
                          margin: EdgeInsets.all(24.0),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x50000000),
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 1.0),
                              ]),
                          child: Center(
                            child: Text(
                              "100,000",
                              style: TextStyle(
                                  fontSize: 34,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          ));
                    }

                    index -= 1;

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 8, bottom: 8),
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            firstColumn,
                            firstColumn,
                            firstColumn
                          ],
                        ),
                      ),
                    );
                  },
                )),
          ],
        ));
  }

  onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );
}
