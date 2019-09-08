import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

class SlideItem extends StatefulWidget {
  final String img;
  final String title;
  final String mission;

  SlideItem({
    Key key,
    @required this.img,
    @required this.title,
    @required this.mission,
  })
      : super(key: key);

  @override
  _SlideItemState createState() => _SlideItemState();
}

class _SlideItemState extends State<SlideItem> {
  createAlertDialog(BuildContext context) {
     TextEditingController customController = TextEditingController();
     return showDialog(context: context,builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text("How much would you like to donate?"), 
          content: TextField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            controller: customController,
          ),
          actions: <Widget> [
            MaterialButton(
              elevation: 5.0,
              child: Text('Donate'),
              onPressed: (){
                CloudFunctions.instance.getHttpsCallable(functionName: "donateMoney").call(
                      <String, dynamic>{
                        'donation': customController.value.text,
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 1.2,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 3.0,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 1.8,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.asset(
                        "${widget.img}",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7.0),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "${widget.title}", overflow: TextOverflow.clip, softWrap: true,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(height: 7.0),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "${widget.mission}", overflow: TextOverflow.clip, softWrap: true,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 7.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text("Donate"),
                    onPressed: () {
                      createAlertDialog(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
