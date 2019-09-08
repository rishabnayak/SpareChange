import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:sparechange/containers/drawer/drawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';



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
          backgroundColor: Colors.blueAccent,
          title: Text('Dashboard',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 25.0)),
        ),
        drawer: DrawerContainer(),
        body: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[
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
                            Text('Hello! Your SpareChange',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20.0)),
                            Text('account value is:',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20.0)),
                            Text('\$18.75',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28.0))
                          ],
                        ),
                        Material(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(24.0),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Icon(Icons.timeline,
                                  color: Colors.white, size: 25.0),
                            )))
                      ])),
              onTap: () => {
                CloudFunctions.instance.getHttpsCallable(functionName: "transferRoundedMoney").call(
                  <String, dynamic>{
                    'spending': 1.23,
                    'checkingAccount': "5d731182322fa016762f2fae",
                    'sparechangeAccount': "5d73258b3c8c2216c9fcac3e",
                  },
                ).then((onValue){
                  print(onValue.data);
                })
              },
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
                          Text('Donate, ya shmucks!', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
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
                    ])),
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
                          Text('Transcation History',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                        ],
                      ),
                      Material(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(24.0),
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(Icons.history,
                                color: Colors.white, size: 30.0),
                          )))
                    ])),
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
                         Text('Your Total Donations:',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                          Text('5',
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
              ),   
              
      
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, 200.0),
            StaggeredTile.extent(2, 135.0),
            StaggeredTile.extent(2, 135.0),
            StaggeredTile.extent(2, 135.0),
            StaggeredTile.extent(2, 135.0),
          ],
        ));
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }
}
