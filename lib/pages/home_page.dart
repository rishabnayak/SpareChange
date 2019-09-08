import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:sparechange/containers/drawer/drawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sparechange/models/app_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sparechange/pages/donation_page.dart';
import 'package:redux/redux.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  createAlertDialog(BuildContext context) {
     TextEditingController customController = TextEditingController();
     return showDialog(context: context,builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text("Add Transaction"), 
          content: TextField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            controller: customController,
          ),
          actions: <Widget> [
            MaterialButton(
              elevation: 5.0,
              child: Text('Add'),
              onPressed: (){
                CloudFunctions.instance.getHttpsCallable(functionName: "transferRoundedMoney").call(
                      <String, dynamic>{
                        'spending': customController.value.text,
                        'checkingAccount': "5d731182322fa016762f2fae",
                        'sparechangeAccount': "5d73258b3c8c2216c9fcac3e",
                      },
                    ).then((onValue){
                      print(onValue.data);
                      Navigator.pop(context);
                    });
              },
            )
          ]
        );
     });
  }

  List<double> chart = [0.0];
  double balance = 0;
  double donated = 0;
  int numberofdonations = 0;

  @override
  void initState() {
    super.initState();
    CloudFunctions.instance
        .getHttpsCallable(functionName: "getDonationHistory")
        .call(
      <String, dynamic>{
        'sparechangeAccount': "5d73258b3c8c2216c9fcac3e",
      },
    ).then((onValue) {
      List jsondata = json.decode(onValue.data);
      double donatedamount = 0;
      int numberdonations = jsondata.length;
      jsondata.forEach((f) {
        donatedamount = donatedamount + f['amount'];
      });
      setState(() {
        donated = donatedamount;
        numberofdonations = numberdonations;
      });
    });
    CloudFunctions.instance
        .getHttpsCallable(functionName: "viewBalanceSparechange")
        .call(
      <String, dynamic>{
        'sparechangeAccount': "5d73258b3c8c2216c9fcac3e",
      },
    ).then((onValue) {
      setState(() {
        balance = json.decode(onValue.data)['balance'];
      });
    });
    CloudFunctions.instance
        .getHttpsCallable(functionName: "getAccountHistory")
        .call(
      <String, dynamic>{
        'sparechangeAccount': "5d73258b3c8c2216c9fcac3e",
      },
    ).then((onValue) {
      List jsondata = json.decode(onValue.data);
      List<double> chartdata = [0.0];
      jsondata.forEach((f) {
        chartdata.add(chartdata.last + f['amount']);
      });
      setState(() {
        chart = chartdata;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        // onInit: (store) => store.dispatch(new InitAction()),
        // onDispose: (store) => store.dispatch(new DisposeAction()),
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blueAccent,
                title: new Text('Dashboard'),
              ),
              drawer: DrawerContainer(),
              body: StaggeredGridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                    'Hello ' +
                                        vm.currentUser.data['displayName']
                                            .toString()
                                            .split(" ")[0] +
                                        '! Your SpareChange',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.0)),
                                Text('account balance is:',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.0)),
                                Text('\$' + balance.toStringAsFixed(2),
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 28.0))
                              ],
                            ),
                          ])),
                  _buildTile(
                      Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Donate!',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24.0)),
                                  ],
                                ),
                                Material(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(24.0),
                                    child: Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.hotel,
                                          color: Colors.white, size: 30.0),
                                    )))
                              ])), onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return DonationPage();
                        },
                      ),
                    );
                  }),
                  _buildTile(
                    Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Total donated:',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.0)),
                                    Text('\$' + donated.toStringAsFixed(2),
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 26.0)),
                                  ],
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(bottom: .5)),
                            Sparkline(
                              data: chart,
                              lineWidth: 5.0,
                              lineColor: Colors.blueAccent,
                            )
                          ],
                        )),
                  ),
                  _buildTile(
                    Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Total Donations:',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24.0)),
                                  Text(numberofdonations.toString(),
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 34.0))
                                ],
                              ),
                              Material(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(24.0),
                                  child: Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(Icons.stars,
                                        color: Colors.white, size: 30.0),
                                  )))
                            ])),
                            onTap: (){
                              Navigator.of(context).pushReplacementNamed("/");
                            }
                  ),
                ],
                staggeredTiles: [
                  StaggeredTile.extent(2, 145.0),
                  StaggeredTile.extent(2, 120.0),
                  StaggeredTile.extent(2, 200.0),
                  StaggeredTile.extent(2, 120.0),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.monetization_on),
                onPressed: (){
                  createAlertDialog(context);
                },
              ),
            );
        });
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }
}

class _ViewModel {
  final DocumentSnapshot currentUser;

  _ViewModel({@required this.currentUser});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      currentUser: store.state.currentUser,
    );
  }
}
