import 'package:flutter/material.dart';
import 'package:sparechange/containers/auth_button/auth_button_container.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: new Stack(
        children: <Widget>[
          new Container(
            alignment: Alignment.center,
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: new Image.asset('assets/images/ic_launcher.png'),
                ),
              ],
            ),
          ),
          new Container(
            alignment: Alignment.bottomCenter,
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 600.0),
                  child: new GoogleAuthButtonContainer(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
