import 'package:flutter/material.dart';
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
          elevation: 0.0,
          title: new Text("Nonprofits"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios
            ),
            onPressed: ()=>Navigator.pop(context),
          ),
        ),
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
