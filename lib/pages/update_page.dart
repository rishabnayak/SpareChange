import 'package:flutter/material.dart';
import 'package:sparechange/containers/registration/reg_form_container.dart';
import 'package:sparechange/containers/drawer/drawer.dart';

class UpdatePage extends StatelessWidget {
  final String title;

  UpdatePage(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: new Text(this.title),
      ),
      drawer: DrawerContainer(),
      body: new SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: new RegFormContainer(),
        ),
      ),
    );
  }
}
