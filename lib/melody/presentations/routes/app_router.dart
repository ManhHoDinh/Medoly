import 'package:flutter/material.dart';
import 'package:melody/melody/presentations/screens/Discovery/discovery_screen.dart';
import 'package:melody/melody/presentations/screens/Home/home_screen.dart';
import 'package:melody/melody/presentations/screens/account/login_screen.dart';
import 'package:melody/melody/presentations/screens/account/sign_up_screen.dart';
import 'package:melody/melody/presentations/screens/account/sign_up_screen.dart';
import 'package:melody/melody/presentations/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  SplashScreen.routeName: (context) => SplashScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  LoginScreen.routeName : (context) => LoginScreen(),
  SplashScreen.routeName : (context) => SplashScreen(),
  SignUpScreen.routeName : (context) => SignUpScreen(),
};

// class Routes {
//     static String discovery = '/discovery';
// }


class Routes {
  static String playing = '/playing';
  static String queue = '/queue';
}
  
