import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sparechange/actions/reg_actions.dart';
import 'package:sparechange/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:sparechange/keys/keys.dart';

List<Middleware<AppState>> createRegMiddleware() {
  final update = _createUpdateMiddleware();
  return [
    new TypedMiddleware<AppState, UpdateDB>(update),
  ];
}

Middleware<AppState> _createUpdateMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    final Firestore _db = Firestore.instance;
    final navigatorKey = AppKeys.navKey;
    if (action is UpdateDB) {
      try {
        DocumentReference mydb = _db.collection('users').document(action.uid);
        Map<String, String> data = <String, String>{
          "uname": action.uname,
          "city": action.city,
          "stt": action.stt,
          "number": action.number,
          "banknum": action.banknum,
          "squarechange": action.squarechange
        };
        await mydb.updateData(data);
        DocumentSnapshot user = await mydb.get();
        store.dispatch(new RunUpdateReducer(user: user));
        navigatorKey.currentState.pushReplacementNamed("/");
      } catch (error) {
        print(error);
      }
    }
  };
}
