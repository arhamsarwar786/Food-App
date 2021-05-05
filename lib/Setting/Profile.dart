import 'package:food_home/login.dart';
import 'package:food_home/signup.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileGuest extends StatefulWidget {
  @override
  _ProfileGuestState createState() => _ProfileGuestState();
}

class _ProfileGuestState extends State<ProfileGuest> {
  var fname, lname, email;
  bool isSaved = false;
  @override
  void initState() {
    super.initState();
    initFun();
  }

  initFun() async {
    var sharePref = await SharedPreferences.getInstance();
    setState(() {
      fname = sharePref.getString("fname");
      lname = sharePref.getString("lname");
      email = sharePref.getString("email");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: redTheme,
          title: Text('PROFILE'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            backgroundColor: redTheme,
            strokeWidth: 2,
          ),
          inAsyncCall: isSaved,
          child: Center(
            child: Container(
              child: Column(
                children: [                
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '$fname $lname',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    (fname == "Guest#")
                        ? 'You must sign up for more'
                        : "You are Logged In With $email",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * 0.80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRight,
                            child: Signup(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      color: redTheme,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      padding: const EdgeInsets.all(0.0),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileUser extends StatefulWidget {
  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  var fname, lname, email, password;
  bool isSaved = false;
  @override
  void initState() {
    super.initState();
    initFun();
  }

  initFun() async {
    var sharePref = await SharedPreferences.getInstance();
    setState(() {
      fname = sharePref.getString("fname");
      lname = sharePref.getString("lname");
      email = sharePref.getString("email");
      password = sharePref.getString("password");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: redTheme,
          title: Text('PROFILE'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            backgroundColor: redTheme,
            strokeWidth: 2,
          ),
          inAsyncCall: isSaved,
          child: Center(
            child: Container(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 70.0,
                    backgroundColor: Colors.transparent,
                    child: Image(
                      image: AssetImage(
                        "assets/main.png",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '$fname $lname',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '$email',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * 0.80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () async {
                        setState(() {
                          isSaved = true;
                        });
                        Future.delayed(Duration(milliseconds: 500), () {
                          setState(() {
                            isSaved = false;

                            Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: Login(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          });
                        });
                      },
                      color: redTheme,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      padding: const EdgeInsets.all(0.0),
                      child: Text(
                        'Log out',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:20),
                   Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * 0.80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () async {
                        var sharePref = await SharedPreferences.getInstance();
                        setState(() {
                          isSaved = true;
                          sharePref.clear();
                        });
                        Future.delayed(Duration(milliseconds: 500), () {
                          setState(() {
                            isSaved = false;
                              
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: Login(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          });
                        });
                      },
                      color: redTheme,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      padding: const EdgeInsets.all(0.0),
                      child: Text(
                        'Delete Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
