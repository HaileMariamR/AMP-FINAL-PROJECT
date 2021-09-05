import 'package:flutter/material.dart';
import 'package:frontend/Screens/AddHolyplace.dart';
import 'package:frontend/Screens/AllSubscription.dart';
import 'package:frontend/Screens/DetailPage.dart';
import 'package:frontend/Screens/screens.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/mainscreen':
        return MaterialPageRoute(builder: (context) => MainScreen());
      case '/addschudule':
        return MaterialPageRoute(builder: (context) => AddSchedule());
      case '/addholyplace':
        return MaterialPageRoute(builder: (context) => HolyPlace());
      case '/repmainscreen':
        return MaterialPageRoute(builder: (context) => RepMainScreen());
      case '/adminpage':
        return MaterialPageRoute(builder: (context) => AdminPage());
      case '/accountsettings':
        return MaterialPageRoute(builder: (context) => AccountSetting());
      case '/allscubscription':
        return MaterialPageRoute(builder: (context) => AllSubscription());
      case '/detailpage':
        return MaterialPageRoute(builder: (context) => DetailPage());
      case WellcomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => WellcomeScreen());

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
