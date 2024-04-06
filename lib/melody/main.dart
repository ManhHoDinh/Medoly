import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:melody/melody/presentations/library/all_playlist_screen.dart';
import 'package:melody/melody/presentations/routes/app_router.dart';
import 'package:melody/melody/presentations/screens/Home/home_screen.dart';
import 'package:melody/melody/presentations/screens/Home/navigation_home.dart';
import 'package:melody/melody/presentations/screens/account/login_screen.dart';
import 'package:melody/melody/presentations/screens/instrument/create_instrument_screen.dart';
import 'package:melody/melody/presentations/screens/instrument/detail_instrument_screen.dart';
import 'package:melody/melody/presentations/screens/splash/splash_screen.dart';
import 'core/constants/color_palatte.dart';
import 'core/helper/AuthFunctions.dart';
import 'core/helper/local_storage_helper.dart';
import 'core/models/firebase/firebase_request.dart';

class melodyApp extends StatefulWidget {
  const melodyApp({super.key});

  @override
  State<melodyApp> createState() => _melodyAppState();
}

class _melodyAppState extends State<melodyApp> {
  var auth = FirebaseAuth.instance;
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'melody',
      theme: ThemeData(
        primaryColor: ColorPalette.primaryColor,
        scaffoldBackgroundColor: ColorPalette.backgroundColor,
      ),
      home: AuthenticationWrapper(),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    // Wait for 5 seconds and then hide the splash screen
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showSplash
        ? SplashScreen()
        : StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              } else {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return FutureBuilder(
                    future: AuthServices.UpdateCurrentUser(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Show a loading indicator if necessary
                        return SplashScreen();
                      } else {
                        // If the update is complete, navigate to the MainScreen
                        return NavigationHome();
                      }
                    },
                  );
                } else {
                  return LoginScreen();
                }
              }
            },
          );
  }
}
