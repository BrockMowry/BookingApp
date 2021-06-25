import 'package:booking_app/screens/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Color.fromARGB(255, 250, 250, 250),
        textTheme: GoogleFonts.montserratTextTheme(),
        fontFamily: GoogleFonts.montserrat().fontFamily,
        appBarTheme: AppBarTheme(
          color: Color.fromARGB(255, 250, 250, 250),
          iconTheme: IconThemeData(
            color: Colors.black,
            size: 20,
          ),
          elevation: 0,
        ),
      ),
      home: LandingPage(),
    ),
  );
}
