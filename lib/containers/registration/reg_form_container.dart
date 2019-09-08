import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sparechange/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sparechange/actions/reg_actions.dart';
import 'package:sparechange/keys/keys.dart';

class RegFormContainer extends StatelessWidget {
  RegFormContainer({Key key}) : super(key: key);
  final navigatorKey = AppKeys.navKey;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          return new Container(
            child: Column(
              children: <Widget>[
                new ListTile(
                  title: new TextField(
                    controller: vm.usernameController,
                    onChanged: (text) {
                      vm.unameCheck(text);
                    },
                    decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        hintText: "Username",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32)))),
                  ),
                ),
                new ListTile(
                  title: new TextField(
                    controller: vm.cityController,
                    decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        hintText: "City",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32)))),
                  ),
                ),
                new ListTile(
                  title: new TextField(
                    controller: vm.stateController,
                    decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.location_city),
                        hintText: "State",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32)))),
                  ),
                ),
                new ListTile(
                  title: new TextField(
                    keyboardType: TextInputType.number,
                    controller: vm.phoneController,
                    decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.contact_phone),
                        hintText: "Contact",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32)))),
                  ),
                ),
                new ListTile(
                  title: new TextField(
                    keyboardType: TextInputType.number,
                    controller: vm.bankNumController,
                    decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.account_balance),
                        hintText: "Bank Account Number",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32)))),
                  ),
                ),
                new ListTile(
                  title: new TextField(
                    keyboardType: TextInputType.number,
                    controller: vm.squareChangeController,
                    decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.account_balance_wallet),
                        hintText: "SpareChange Account Number",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Builder(
                    builder: (context) {
                      return RaisedButton(
                        textColor: Colors.white,
                        onPressed: () {
                          vm.update(
                              vm.currentUser.data['uid'],
                              vm.usernameController.text,
                              vm.cityController.text,
                              vm.stateController.text,
                              vm.phoneController.text,
                              vm.bankNumController.text,
                              vm.squareChangeController.text);
                        },
                        color: Colors.blueAccent,
                        child: Text('Submit'),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _ViewModel {
  final DocumentSnapshot currentUser;
  final Function(String) unameCheck;
  final Function(String, String, String, String, String, String, String) update;
  final TextEditingController usernameController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController phoneController;
  final TextEditingController bankNumController;
  final TextEditingController squareChangeController;

  _ViewModel(
      {@required this.currentUser,
      this.unameCheck,
      this.usernameController,
      this.cityController,
      this.stateController,
      this.phoneController,
      this.bankNumController,
      this.squareChangeController,
      this.update});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        unameCheck: (String unamecheck) async {
          final Firestore _db = Firestore.instance;
          QuerySnapshot check = await _db
              .collection('users')
              .where("uname", isEqualTo: unamecheck)
              .getDocuments();
          if (unamecheck == null || unamecheck == "") {
            print("enter something");
          } else if (check.documents.isEmpty ||
              check.documents.single.data['uname'] ==
                  store.state.currentUser.data['uname']) {
            print("available");
          } else {
            print("taken");
          }
        },
        update: (String uid, String uname, String city, String stt,
            String number, String banknum, String squarechange) {
          store.dispatch(UpdateDB(
              uid: uid,
              uname: uname,
              city: city,
              stt: stt,
              number: number,
              banknum: banknum,
              squarechange: squarechange));
        },
        currentUser: store.state.currentUser,
        usernameController: new TextEditingController.fromValue(new TextEditingValue(
            text: store.state.currentUser.data['uname'] ?? "",
            selection: new TextSelection.collapsed(
                offset: store.state.currentUser.data['uname']?.length ?? 0))),
        cityController: new TextEditingController.fromValue(new TextEditingValue(
            text: store.state.currentUser.data['city'] ?? "",
            selection: new TextSelection.collapsed(
                offset: store.state.currentUser.data['city']?.length ?? 0))),
        stateController: new TextEditingController.fromValue(
            new TextEditingValue(
                text: store.state.currentUser.data['stt'] ?? "",
                selection: new TextSelection.collapsed(
                    offset: store.state.currentUser.data['stt']?.length ?? 0))),
        phoneController: new TextEditingController.fromValue(new TextEditingValue(
            text: store.state.currentUser.data['number'] ?? "",
            selection: new TextSelection.collapsed(offset: store.state.currentUser.data['number']?.length ?? 0))),
        bankNumController: new TextEditingController.fromValue(new TextEditingValue(text: store.state.currentUser.data['banknum'] ?? "", selection: new TextSelection.collapsed(offset: store.state.currentUser.data['banknum']?.length ?? 0))),
        squareChangeController: new TextEditingController.fromValue(new TextEditingValue(text: store.state.currentUser.data['squarechange'] ?? "", selection: new TextSelection.collapsed(offset: store.state.currentUser.data['squarechange']?.length ?? 0))));
  }
}
