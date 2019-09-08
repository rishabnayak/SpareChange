import 'package:flutter/material.dart';
import 'package:sparechange/pages/restaurants.dart';
import 'package:sparechange/pages/slide_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home>{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10,15,0,0),
        child: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height/1.2,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: restaurants == null ? 0 :restaurants.length,
                itemBuilder: (BuildContext context, int index) {
                  Map restaurant = restaurants[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: SlideItem(
                      img: restaurant["img"],
                      title: restaurant["title"],
                      address: restaurant["address"],
                      rating: restaurant["rating"],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );

  }

  @override
  bool get wantKeepAlive => true;

}