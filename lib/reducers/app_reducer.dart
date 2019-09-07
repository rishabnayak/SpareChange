import 'package:sparechange/models/app_state.dart';
import 'package:sparechange/reducers/update_reducer.dart';
import 'package:sparechange/reducers/navigation_reducer.dart';

AppState appReducer(state, action) {
  return new AppState(
      isLoading: false,
      currentUser: updateReducer(state.currentUser, action),
      navigationState: navigationReducer(state.navigationState, action));
}
