import 'package:flutter/material.dart';
import 'package:melody/melody/presentations/screens/Discovery/discovery_screen.dart';
import 'package:melody/melody/presentations/screens/Home/home_screen.dart';
import 'package:melody/melody/presentations/screens/account/login_screen.dart';
import 'package:melody/melody/presentations/screens/account/sigg_up_screen.dart';
import 'package:melody/melody/presentations/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  // HomeScreen.routeName: (context) => HomeScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  SplashScreen.routeName: (context) => SplashScreen(),
};

class Routes {
    static String discovery = '/discovery';
}
