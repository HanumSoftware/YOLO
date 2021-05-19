import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yolo/circle_painter.dart';
import 'package:explosion_animation/explosion_animation.dart';
import 'AnimatedBackground.dart';
import 'AnimatedWave.dart';
import 'curve_wave.dart';

var key = Explode.getKey();

class ProtfolioScreen extends StatefulWidget {
  const ProtfolioScreen({
    Key key,
    this.size = 80.0,
    @required this.child,
  }) : super(key: key);
  final double size;
  final Widget child;

  @override
  ProtfolioScreenState createState() => ProtfolioScreenState();
}

class ProtfolioScreenState extends State<ProtfolioScreen>
    with TickerProviderStateMixin {
  AnimationController rippleController,
      textAnimationController,
      cardAnimationController,
      slideAnimationController;
  Animation<double> textAnimation;
  Animation<double> cardAnimation;
  Animation<Offset> slideAnimation;
  Widget rotationView;
  bool worldEventVisibility = false;
  bool giftVisibility = false;
  bool shouldStopPanel = false;
  bool shouldPickGift = false;
  bool shouldRevealCard = false;

  @override
  void initState() {
    super.initState();
    rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    slideAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    textAnimationController = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
        value: 1,
        upperBound: 1,
        lowerBound: 0.8)
      ..repeat(reverse: true);

    cardAnimationController = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this,
        value: 0.5,
        upperBound: 1,
        lowerBound: 0.5);

    textAnimation = CurvedAnimation(
      parent: textAnimationController,
      curve: Curves.linear,
    );

    cardAnimation = CurvedAnimation(
      parent: cardAnimationController,
      curve: Curves.linear,
    );

    slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 0.5),
    ).animate(CurvedAnimation(
      parent: slideAnimationController,
      curve: Curves.ease,
    ));

    rotationView = balanceView;
  }

  @override
  void dispose() {
    rippleController.dispose();
    textAnimationController.dispose();
    cardAnimationController.dispose();
    slideAnimationController.dispose();
    super.dispose();
  }

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
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 24),
                child: Text(
                  "Balance:",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.w300),
                )),
            Container(
                margin: EdgeInsets.only(top: 8),
                child: Text(
                  "\$100,000",
                  style: TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                )),
            Container(
                margin: EdgeInsets.only(top: 24),
                child: Text(
                  "Age:",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.w300),
                )),
            Container(
                margin: EdgeInsets.only(top: 8),
                child: Text(
                  "21",
                  style: TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ))
          ],
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
        PieChartData(sectionsSpace: 0, sections: [
          PieChartSectionData(
              title: "23%",
              value: 23,
              color: Color(0xFFF44336),
              titleStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          PieChartSectionData(
              title: "17%",
              value: 17,
              color: Color(0xFF2196F3),
              titleStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          PieChartSectionData(
              title: "45%",
              value: 45,
              color: Color(0xFF9C27B0),
              titleStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          PieChartSectionData(
              title: "15%",
              value: 15,
              color: Color(0xFF69F0AE),
              titleStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500))
        ]),
        swapAnimationDuration: Duration.zero,
        swapAnimationCurve: Curves.elasticOut),
  );

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

  void startAnimation() => pc
      .animatePanelToPosition(0.1,
          duration: Duration(milliseconds: 1200), curve: Curves.linear)
      .whenComplete(() => pc.animatePanelToPosition(0,
          duration: Duration(milliseconds: 1200), curve: Curves.linear))
      .whenComplete(() => {
            if (!shouldStopPanel) {startAnimation()}
          });

  void displayWorldEvent() {
    pc.close().whenComplete(() => setState(() {
          worldEventVisibility = !worldEventVisibility;
          giftVisibility = false;
          shouldPickGift = false;
        }));
  }

  void displayGift() {
    pc.close().whenComplete(() => setState(() {
          giftVisibility = !giftVisibility;
          worldEventVisibility = false;
          shouldPickGift = false;
        }));
  }

  void openGift() {
    pc.hide();
    setState(() {
      shouldPickGift = true;
      worldEventVisibility = false;
    });

    slideAnimationController.forward();
    revealGiftCard();
  }

  void revealGiftCard() {
    Future.delayed(const Duration(milliseconds: 500), () {
      key.currentState.explode();
    }).whenComplete(
        () => Future.delayed(const Duration(milliseconds: 1200), () {
              cardAnimationController.forward();

              setState(() {
                shouldRevealCard = true;
              });
            }));
  }

  void displayEndTurn() {}

  void launchWorldEvent() {}

  Widget _worldEvent() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.size),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[
                Colors.white,
                Color.lerp(Colors.white, Colors.black, .05)
              ],
            ),
          ),
          child: ScaleTransition(
              scale: Tween(begin: 0.85, end: 1.0).animate(
                CurvedAnimation(
                  parent: rippleController,
                  curve: const CurveWave(),
                ),
              ),
              child: Image(
                image: AssetImage('assets/world_event.png'),
                height: 130,
                width: 130,
              )),
        ),
      ),
    );
  }

  Widget _gift() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.size),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[
                Colors.white,
                Color.lerp(Colors.white, Colors.black, .05)
              ],
            ),
          ),
          child: ScaleTransition(
              scale: Tween(begin: 0.85, end: 1.0).animate(
                CurvedAnimation(
                  parent: rippleController,
                  curve: const CurveWave(),
                ),
              ),
              child: Explode(
                key: key,
                size: Size(130, 130),
                fit: BoxFit.contain,
                particleCount: 200,
                path: 'assets/gift.png',
                type: ExplodeType.Spread,
                isAsset: true,
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => {if (!shouldStopPanel) startAnimation()});
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

    return SlidingUpPanel(
        controller: pc,
        maxHeight: 220,
        minHeight: 40,
        panel: InkWell(
          onTap: () {
            pc.open();
          },
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                    child: InkWell(
                        splashColor: Colors.black,
                        onTap: () {
                          displayGift();
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          height: 100,
                          child: Column(children: <Widget>[
                            Center(
                                child: Text(
                              "Gift",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w400),
                            )),
                            Image(
                              image: AssetImage('assets/gift.gif'),
                              width: 70,
                              height: 70,
                            )
                          ]),
                        ))),
                Expanded(
                    child: InkWell(
                        splashColor: Colors.black,
                        onTap: () {
                          displayWorldEvent();
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          child: Column(children: <Widget>[
                            Center(
                                child: Text(
                              "World Event",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            )),
                            Image(
                              image: AssetImage('assets/world_event.gif'),
                              width: 100,
                              height: 100,
                            )
                          ]),
                          height: 130,
                        ))),
                Expanded(
                    child: InkWell(
                        splashColor: Colors.black,
                        onTap: () {
                          displayEndTurn();
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          height: 100,
                          child: Column(children: <Widget>[
                            Center(
                                child: Text(
                              "End Turn",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w400),
                            )),
                            Image(
                              image: AssetImage('assets/end_turn.gif'),
                              width: 70,
                              height: 70,
                            )
                          ]),
                        ))),
              ],
            ),
          ),
        ),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100.0), topRight: Radius.circular(100.0)),
        onPanelOpened: () => {
              this.setState(() {
                shouldStopPanel = true;
              })
            },
        onPanelClosed: () => {},
        body: Stack(
          children: <Widget>[
            Positioned.fill(child: AnimatedBackground()),
            onBottom(AnimatedWave(
              height: 340,
              speed: 0.9,
            )),
            onBottom(AnimatedWave(
              height: 390,
              speed: 0.7,
              offset: pi,
            )),
            onBottom(AnimatedWave(
              height: 430,
              speed: 1,
              offset: pi / 2,
            )),
            Container(
                margin: const EdgeInsets.only(top: 0, bottom: 160),
                child: ListView.builder(
                  padding:
                      EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 70),
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
            AnimatedOpacity(
                opacity: worldEventVisibility ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: Container(
                  height: worldEventVisibility ? double.infinity : 0,
                  width: double.infinity,
                  color: Color(0x99000000),
                  child: Column(children: <Widget>[
                    CustomPaint(
                      painter: CirclePainter(
                        rippleController,
                        color: Colors.white,
                      ),
                      child: SizedBox(
                        width: widget.size * 4.125,
                        height: widget.size * 4.125,
                        child: _worldEvent(),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(24),
                        child: Text(
                          "Launch world event?",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 80),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                                child: Center(
                                    child: new InkWell(
                                        onTap: () {
                                          launchWorldEvent();
                                        },
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(
                                              fontSize: 55,
                                              color: Colors.white),
                                        )))),
                            Expanded(
                                child: Center(
                                    child: new InkWell(
                                        onTap: () {
                                          setState(() {
                                            worldEventVisibility = false;
                                          });
                                        },
                                        child: Text(
                                          "No",
                                          style: TextStyle(
                                              fontSize: 55,
                                              color: Colors.white),
                                        ))))
                          ],
                        ))
                  ]),
                )),
            AnimatedOpacity(
                opacity: giftVisibility ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Container(
                  height: giftVisibility ? double.infinity : 0,
                  width: double.infinity,
                  color: Color(0x99000000),
                  child: Column(children: <Widget>[
                    SlideTransition(
                        position: slideAnimation,
                        child: CustomPaint(
                          painter: CirclePainter(
                            rippleController,
                            color: Colors.white,
                          ),
                          child: SizedBox(
                            width: widget.size * 4.125,
                            height: widget.size * 4.125,
                            child: _gift(),
                          ),
                        )),
                    AnimatedOpacity(
                        opacity: shouldPickGift ? 0 : 1,
                        duration: Duration(milliseconds: 500),
                        child: Container(
                            child: Text(
                          "Open the gift?",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ))),
                    AnimatedOpacity(
                        opacity: shouldPickGift ? 0 : 1,
                        duration: Duration(milliseconds: 500),
                        child: Container(
                            margin: EdgeInsets.all(24),
                            child: Container(
                                margin: EdgeInsets.only(top: 80),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Expanded(
                                        child: Center(
                                            child: new InkWell(
                                                onTap: () {
                                                  openGift();
                                                },
                                                child: Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      fontSize: 55,
                                                      color: Colors.white),
                                                )))),
                                    Expanded(
                                        child: Center(
                                            child: new InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    giftVisibility = false;
                                                  });
                                                },
                                                child: Text(
                                                  "No",
                                                  style: TextStyle(
                                                      fontSize: 55,
                                                      color: Colors.white),
                                                ))))
                                  ],
                                ))))
                  ]),
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
