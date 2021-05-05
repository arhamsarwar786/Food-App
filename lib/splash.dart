import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_home/catorgry_lndngPge.dart';
import 'login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var fname , lname ;
  startTime() async {
    var sharePref = await SharedPreferences.getInstance();
  setState(() {
      fname =sharePref.getString("fname");
    lname =sharePref.getString("lname");
  });
    var duration = Duration(seconds: 5);
    return Timer(duration, navigationPage);
  }

  void navigationPage() {
    (fname == "Guest#" || fname == null)?
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(type: PageTransitionType.rightToLeft, child:  Login()),
      (_) => false,
    ):  Navigator.pushAndRemoveUntil(
      context,
      PageTransition(type: PageTransitionType.rightToLeft, child:  LandingScreen()),
      (_) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: Image.asset(
                'assets/images/Presentation1.gif',
                height: 300,
                width: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
