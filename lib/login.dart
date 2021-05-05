import 'dart:math';
import 'dart:ui';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'catorgry_lndngPge.dart';
import 'constants.dart';
import 'signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //// Adds

  ///
  ///

  bool invisible = true, isSaved = false;
  var randomNumber;
  void inContact(TapDownDetails details) {
    setState(() {
      invisible = false;
    });
  }

  void outContact(TapUpDetails details) {
    setState(() {
      invisible = true;
    });
  }

  /////   Hide Show Methods
  ///
  bool isHidden = true;
  toggleMethod() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  var emailVal, passVal;
  var emailShare, passwordShare, fname, lname;

  @override
  void initState() {
    super.initState();
      // AdmobService.createBannerAd()..load();
    initFun();
  }

  initFun() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      emailShare = sharedPreferences.getString("email");
      passwordShare = sharedPreferences.getString("password");
      fname = sharedPreferences.getString("fname");
      lname = sharedPreferences.getString("lname");
      Random random = Random();
      randomNumber = random.nextInt(1000);
    });
  }

  var email = TextEditingController();
  var password = TextEditingController();

  var formKey = GlobalKey<FormState>();

  //////////////    For  validator   ///////////////
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email or Phone Number is required '),
    PatternValidator(r'@', errorText: 'Enter Valid Email or Phone Number ')
  ]);
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required '),
  ]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          backgroundColor: redTheme,
          strokeWidth: 2,
        ),
        inAsyncCall: isSaved,
        child: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: SafeArea(
            child: Builder(
              builder: (context) {
                return Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: CircleAvatar(
                            radius: 70.0,
                            backgroundColor: Colors.white,
                            child: Image(
                              image: AssetImage(
                                "assets/images/main.png",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'AL-MADINAH FOODS',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: redTheme,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'SIGN IN FOR LOGIN',
                          style: TextStyle(
                            color: redTheme,
                            letterSpacing: 05.0,
                          ),
                        ),
                        SizedBox(
                          width: 150.0,
                          height: 10.0,
                          child: Divider(
                            color: redTheme,
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(Icons.email_outlined,
                                size: 35.0, color: redTheme),
                            title: TextFormField(
                        cursorColor: redTheme,
                              controller: email,
                              validator: emailValidator,
                              onChanged: (val) => emailVal = val,
                              decoration: InputDecoration(
                                labelText: 'EMAIL',
                                labelStyle: TextStyle(
                                  color: redTheme,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0),
                          child: Container(
                            child: ListTile(
                              leading: Icon(
                                Icons.lock_outlined,
                                textDirection: TextDirection.ltr,
                                size: 35.0,
                                color: redTheme,
                              ),
                              title: TextFormField(
                        cursorColor: redTheme,                                
                                controller: password,
                                onChanged: (val) => passVal = val,
                                validator: passwordValidator,
                                obscureText: isHidden,
                                decoration: InputDecoration(
                                  labelText: 'PASSWORD',
                                  labelStyle: TextStyle(
                                    color: redTheme,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTapDown:
                                        inContact, //call this method when incontact
                                    onTapUp:
                                        outContact, //call this method when contact with screen is removed
                                    child: IconButton(
                                      onPressed: () {
                                        toggleMethod();
                                      },
                                      icon: isHidden
                                          ? Icon(
                                              Icons.visibility_off,
                                            )
                                          : Icon(
                                              Icons.visibility,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 10.0,
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
                              FocusScope.of(context).requestFocus(FocusNode());
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();

                              if (formKey.currentState.validate()) {
                                setState(() {
                                  if (emailShare == email.text &&
                                      passwordShare == password.text) {
                                    setState(() {
                                      isSaved = true;
                                    });
                                    // print("Vertify ......");

                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: redTheme,
                                        content: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            " Successfully Logged In   .... ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    );

                                    Future.delayed(Duration(seconds: 1), () {
                                      setState(() {
                                        isSaved = false;

                                        sharedPreferences.setString(
                                            "fname", fname);
                                        sharedPreferences.setString(
                                            "lname", lname);
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeftWithFade,
                                              child: LandingScreen(),
                                            ),
                                            (Route<dynamic> route) => false);
                                        Scaffold.of(context)
                                            .removeCurrentSnackBar();
                                        email.clear();
                                        password.clear();
                                      });
                                    });
                                  } else {
                                    // print("Not - Vertify ......");

                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: redTheme,
                                        content: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            " Your Email Or Password Incorrect   .... ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                });
                              } else {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: redTheme,
                                    content: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        "Use Proper Email or Mobile Number",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            color: redTheme,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                color: Colors.teal.shade50,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Don't have an Account?"),
                              // ignore: deprecated_member_use
                              FlatButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType
                                          .rightToLeftWithFade,
                                      child: Signup(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                    color: redTheme,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: Colors.grey[300],
                          onPressed: () async {
                            setState(() {
                              isSaved = true;
                            });

                            ///
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            setState(() {
                              sharedPreferences.setString("fname", "Guest#");
                              sharedPreferences.setString(
                                  "lname", randomNumber.toString());
                            });

                            Future.delayed(Duration(seconds: 1), () {
                              setState(() {
                                isSaved = false;

                                //  AdmobService.showInterstitialAd();
                                //showRandomInterstitialAd();
                             


                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    child: LandingScreen(),
                                  ),
                                );
                              });
                            });
                          },
                          child: Text(
                            "Skip for Now ",
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
