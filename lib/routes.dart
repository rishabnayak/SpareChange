library routes;

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sparechange/pages/auth_page.dart';
import 'package:sparechange/pages/loading_page.dart';
import 'package:sparechange/pages/register_page.dart';
import 'package:sparechange/pages/home_page.dart';
import 'package:sparechange/pages/donation_page.dart';
import 'models/app_state.dart';
import 'package:sparechange/pages/update_page.dart';

Map<String, WidgetBuilder> getRoutes(context, store) {
  return {
    '/': (BuildContext context) => new StoreBuilder<AppState>(
          builder: (context, store) {
            return HomePage();
          },
        ),
    '/update': (BuildContext context) => new StoreBuilder<AppState>(
          builder: (context, store) {
            return UpdatePage("Update Details");
          },
        ),
    '/register': (BuildContext context) => new StoreBuilder<AppState>(
          builder: (context, store) {
            return RegisterPage("Register");
          },
        ),
    '/login': (BuildContext context) => new StoreBuilder<AppState>(
          builder: (context, store) {
            return AuthPage();
          },
        ),
    '/loading': (BuildContext context) => new StoreBuilder<AppState>(
          builder: (context, store) {
            return LoadingPage();
          },
        ),
    '/donate': (BuildContext context) => new StoreBuilder<AppState>(
          builder: (context, store) {
            return DonationPage();
          },
        ),
  };
}
