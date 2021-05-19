import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'MarketScreen.dart';
import 'ProtfolioScreen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  MotionTabController _tabController;

  AnimationController _controller;

  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _tabController = MotionTabController(initialIndex: 1, vsync: this);

    _controller = AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
        value: 1,
        lowerBound: 0.5,
        upperBound: 1)
      ..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: MotionTabBar(
          labels: ["Inventory", "Protfolio", "Market"],
          initialSelectedTab: "Protfolio",
          tabIconColor: Colors.green,
          tabSelectedColor: Colors.green,
          onTabItemSelected: (int value) {
            setState(() {
              _tabController.index = value;
            });
          },
          icons: [
            Icons.shopping_bag_rounded,
            Icons.dashboard_rounded,
            Icons.store_rounded
          ],
          textStyle: TextStyle(color: Colors.green),
        ),
        body: SafeArea(
            child: Stack(children: <Widget>[
          Container(
              child: MotionTabBarView(
            controller: _tabController,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 64),
                child: Center(
                  child: Text("Inventory"),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 64), child: ProtfolioScreen()),
              Container(margin: EdgeInsets.only(top: 64), child: MarketScreen())
            ],
          )),
          Container(
            width: double.infinity,
            color: Colors.white,
            height: 56,
            child: Center(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 24, top: 8),
                    child: Row(children: <Widget>[
                      Text(
                        "Turn: ",
                        style: TextStyle(fontSize: 20),
                      ),
                      FadeTransition(
                        opacity: _animation,
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(width: 3, color: Colors.green)),
                          child: Center(
                              child: Text(
                            "דח",
                            style: TextStyle(fontWeight: FontWeight.w800),
                          )),
                        ),
                      )
                    ]),
                  )
                ],
              ),
            ),
          )
        ])));
  }
}
