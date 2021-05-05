import 'dart:ui';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:food_home/constants.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var fname = TextEditingController();
  var lname = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var confirm = TextEditingController();
  bool isSaved = false;
  SharedPreferences sharedPreferences;

  ////////////    VAlidator //////////
  var emailVal, passVal;
  var formKey = GlobalKey<FormState>();
  //////////////    For  validator   ///////////////
  final fnameValidator = MultiValidator([
    RequiredValidator(errorText: 'First Name is required '),
  ]);
  final lnameValidator = MultiValidator([
    RequiredValidator(errorText: 'Last Name is required '),
  ]);
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email or Phone Number is required '),
    PatternValidator(r'@', errorText: 'Enter Valid Email or Phone Number ')
  ]);
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required '),
  ]);

  /////   Hide Show Methods
  ///
  bool isHidden = true;
  toggleMethod() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: Login(),
              ),
              (Route<dynamic> route) => false,
            );
          },
        ),
        title: Text(
          'Sign Up',
          // style: TextStyle(color: Colors.teal.shade500, fontFamily: 'Pacifico'),
        ),
      ),
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) {
          return ModalProgressHUD(
            progressIndicator: CircularProgressIndicator(
              backgroundColor: redTheme,
              strokeWidth: 2,
            ),
            inAsyncCall: isSaved,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          'Al Madina Foods',
                          style: TextStyle(
                              color: redTheme,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                        child: Divider(
                          color: Colors.teal.shade300,
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 25,
                        ),
                        child: ListTile(
                          title: TextFormField(
                        cursorColor: redTheme,
                            validator: fnameValidator,
                            controller: fname,
                            decoration: InputDecoration(
                              labelText: 'First Name',
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          title: TextFormField(
                        cursorColor: redTheme,
                            validator: lnameValidator,
                            controller: lname,
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          title: TextFormField(
                        cursorColor: redTheme,
                            validator: emailValidator,
                            controller: email,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          title: TextFormField(
                        cursorColor: redTheme,
                            validator: passwordValidator,
                            onChanged: (val) => passVal = val,
                            controller: password,
                            obscureText: isHidden,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: IconButton(
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
                      Card(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          title: TextFormField(
                        cursorColor: redTheme,
                            controller: confirm,
                            validator: (val) => MatchValidator(
                                    errorText: 'passwords do not match')
                                .validateMatch(val, passVal),
                            obscureText: isHidden,
                            decoration: InputDecoration(
                              labelText: 'Confirm password',
                              suffixIcon: IconButton(
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
                      SizedBox(height: 10),
                      Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: RaisedButton(
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());

                            if (formKey.currentState.validate()) {
                              setState(() {
                                isSaved = true;
                              });
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();

                              sharedPreferences.setString("fname", fname.text);
                              sharedPreferences.setString("lname", lname.text);
                              sharedPreferences.setString("email", email.text);
                              sharedPreferences.setString(
                                  "password", password.text);

                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: redTheme,
                                  content: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      " Account Created  .... ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              );

                              Future.delayed(Duration(seconds: 2), () {
                                setState(() {
                                  isSaved = false;
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType
                                          .rightToLeftWithFade,
                                      child: Login(),
                                    ),
                                  );
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  fname.clear();
                                  lname.clear();
                                  email.clear();
                                  password.clear();
                                  confirm.clear();
                                });
                              });
                            } else {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: redTheme,
                                  content: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      " Fill All Fields",
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
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              color: Colors.teal.shade50,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}