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
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}