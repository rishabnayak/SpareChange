import 'package:flutter/material.dart';
import 'package:sparechange/constants/colors.dart';
import 'package:sparechange/containers/drawer/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MeSuiteColors.blue,
        title: Text("SpareChange"),
      ),
      drawer: DrawerContainer(),
      body: Text("Yooo"),
    );
  }
}
