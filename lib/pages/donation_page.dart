import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:sparechange/containers/drawer/drawer.dart';
import 'package:sparechange/pages/home.dart';

class DonationPage extends StatefulWidget {

    
  @override
  DonationPageState createState() => DonationPageState();
}

class DonationPageState extends State<DonationPage> {

  @override
  Widget build(BuildContext context) {
        return Scaffold(
                  appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: new Text('Nonprofits'),
        ),
        drawer: DrawerContainer(),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Home(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

}
