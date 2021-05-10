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

  @override
  void initState() {
    super.initState();
    _tabController = MotionTabController(initialIndex: 1, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: MotionTabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              child: Center(
                child: Text("Inventory"),
              ),
            ),
            ProtfolioScreen(),
            MarketScreen()
          ],
        ));
  }
}
