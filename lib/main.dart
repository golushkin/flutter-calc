import 'package:calculator/calories/calories_tab.dart';
import 'package:flutter/material.dart';
import './bmi/bmi_tab.dart';

void main() {
  runApp(TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Text("BMI"),
                Text("Calories"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              BmiTab(),
              CaloriesTab(),
            ],
          ),
        ),
      ),
    );
  }
}