import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'AnimatedBackground.dart';
import 'AnimatedWave.dart';

class ProtfolioScreen extends StatefulWidget {
  ProtfolioScreen({Key key}) : super(key: key);

  @override
  ProtfolioScreenState createState() => ProtfolioScreenState();
}

class ProtfolioScreenState extends State<ProtfolioScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Widget rotationView;

  Widget balanceView = Container(
      height: 230,
      width: 230,
      key: Key("balanceView"),
      margin: EdgeInsets.all(24.0),
      decoration: BoxDecoration(
          color: Color(0x50263238),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Color(0x50000000),
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 1.0),
          ]),
      child: Center(
        child: Text(
          "\$100,000",
          style: TextStyle(
              fontSize: 34, color: Colors.white, fontWeight: FontWeight.w300),
        ),
      ));

  Widget pieChart = Container(
    height: 230,
    width: 230,
    key: Key("pieChart"),
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
    child: PieChart(
        PieChartData(sectionsSpace: 8, sections: [
          PieChartSectionData(
              title: "23%",
              color: Color(0xFFF44336),
              titleStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          PieChartSectionData(
              title: "17%",
              color: Color(0xFF2196F3),
              titleStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          PieChartSectionData(
              title: "45%",
              color: Color(0xFF9C27B0),
              titleStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          PieChartSectionData(
              title: "15%",
              color: Color(0xFF69F0AE),
              titleStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500))
        ]),
        swapAnimationDuration: Duration.zero,
        swapAnimationCurve: Curves.elasticOut),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(milliseconds: 1000),
    );

    rotationView = balanceView;
  }

  final PanelController pc = new PanelController();

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget firstColumn = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'ALPH-Y',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text('Alpharium YOLO',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              )),
        ],
      ),
    );

    Widget thirdColumn = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            '13',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          Text('\$3088,13', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );

    startAnimation() => pc
        .animatePanelToPosition(0.1,
            duration: Duration(milliseconds: 1200), curve: Curves.linear)
        .whenComplete(() => pc.animatePanelToPosition(0,
            duration: Duration(milliseconds: 1200), curve: Curves.linear));

    return SlidingUpPanel(
        controller: pc,
        maxHeight: 200,
        minHeight: 40,
        panel: Column(),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100.0), topRight: Radius.circular(100.0)),
        onPanelOpened: () => {},
        onPanelClosed: () => {startAnimation()},
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
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (rotationView == balanceView) {
                                rotationView = pieChart;
                              } else {
                                rotationView = balanceView;
                              }
                            });
                          },
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                  child: child, scale: animation);
                            },
                            child: rotationView,
                          ));
                    }

                    index -= 1;

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 8, bottom: 8),
                      color: Colors.transparent,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            child: Image(
                              image: AssetImage('assets/airplane.png'),
                              height: 40,
                              width: 40,
                            ),
                            top: 20,
                            left: 20,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, bottom: 16, left: 80, right: 40),
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      firstColumn,
                                      thirdColumn
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 16, bottom: 8),
                                    width: double.infinity,
                                    height: 1.5,
                                    color: Colors.grey.withAlpha(60),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Text("\$241.31",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                            Container(
                                              child: Text(
                                                "+2.43%",
                                                style: TextStyle(
                                                    color: Color(0xFF427E29),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            )
                                          ]))
                                    ],
                                  )
                                ],
                              ))
                        ],
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
