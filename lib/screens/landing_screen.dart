import 'package:booking_app/models/user.dart';
import 'package:booking_app/screens/home/home_screen.dart';
import 'package:booking_app/screens/wifi_required.dart';
import 'package:booking_app/services/authentication.dart';
import 'package:booking_app/services/database.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/login_screen.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();

    init();
  }

  void init() async {
    // check to see if the user is connected to the internet.
    // if not, redirect them to a screen that says they need wifi.
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WifiRequired(),
        ),
      );

      return;
    }

    final bool loginResult = await _handleLogin();
    if (loginResult) {
      await Database.instance.load();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );

      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  Future<bool> _handleLogin() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String email = sharedPreferences.getString('email');
    final String password = sharedPreferences.getString('password');
    if ((email == null) || (password == null)) return false;

    final Authentication authentication = Authentication.instance;
    final BAUser user = await Authentication.instance.logIn(email, password);
    if (user != null) {
      print('Logging in using saved info...');
      authentication.setCurrentUser(user);

      return true;
    }

    return false;
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor,
            ),
            backgroundColor: Colors.grey[300],
          ),
        ),
      ),
    );
  }
}
