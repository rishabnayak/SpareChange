import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateDB {
  String uid;
  String uname;
  String city;
  String stt;
  String number;
  String banknum;
  String squarechange;

  UpdateDB(
      {@required this.uid,
      @required this.uname,
      @required this.city,
      @required this.stt,
      @required this.number,
      @required this.banknum,
      @required this.squarechange});
}

class RunUpdateReducer {
  final DocumentSnapshot user;

  RunUpdateReducer({@required this.user});
}
