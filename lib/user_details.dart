import 'package:flutter/material.dart';
import 'package:food_home/paymentsMethods.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'constants.dart';
import 'package:page_transition/page_transition.dart';

class UserDetail extends StatefulWidget {
  final listGet, finalTotal;
  UserDetail([this.listGet, this.finalTotal]);
  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  ///    Validation  /////
  ///
  final requiredField = MultiValidator([
    RequiredValidator(errorText: 'Field is required '),
  ]);

  final phoneValidator = MultiValidator([
    RequiredValidator(errorText: 'Phone Number is required '),
    PatternValidator(r'3', errorText: 'Enter Valid Phone Number ')
  ]);

   final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required '),
    PatternValidator(r'@', errorText: 'Enter Valid Email or Phone Number ')
  ]);
  //////////////////////////////////////////////////////////////////////
  var name = TextEditingController();
  var phone = TextEditingController();
  var address = TextEditingController();
  var email = TextEditingController();
  var message = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Details",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: redTheme,
        elevation: 0.0,
      ),
      body: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 1),
            child: SingleChildScrollView(
              child: Container(
                child: Form(
                  key: formKey,
                  child: Column(children: [
                    Container(
                      child: CircleAvatar(
                        radius: 70.0,
                        backgroundColor: Colors.transparent,
                        child: Image(
                          image: AssetImage(
                            "assets/images/main.png",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Enter your Details",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        validator: requiredField,
                        cursorColor: redTheme,
                        controller: name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[200], width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: redTheme, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: "Name",
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        cursorColor: redTheme,
                        validator: phoneValidator,
                        controller: phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[200], width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: redTheme, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: "Phone Number",
                          helperText: "03xxxxxxxxx",
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        validator: requiredField,
                        cursorColor: redTheme,
                        controller: address,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[200], width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: redTheme, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: "Address",
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                      Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        validator: emailValidator,
                        cursorColor: redTheme,
                        controller: email,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[200], width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: redTheme, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: "Email",
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        validator: requiredField,
                        cursorColor: redTheme,
                        controller: message,
                        maxLength: 500,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[200], width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: redTheme, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: "Comment",
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());

                              if (formKey.currentState.validate()) {
                                var number;
                                var mobileNumber = phone.text;
                                if (mobileNumber[0] == '0') {
                                  number = mobileNumber.substring(1);
                                  number = '+92' + number;
                                } else if (mobileNumber[0] == '3') {
                                  number = '+92' + mobileNumber;
                                } else {
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: redTheme,
                                      content: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          " Enter in 03xxxxxxxxx Format ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: PaymentsMethods(
                                        name.text,
                                        number,
                                        address.text,
                                        email.text,
                                        message.text,
                                        widget.listGet,
                                        widget.finalTotal),
                                  ),
                                );
                              }
                            },
                            color: Color(0xffA02621),
                            child: Text(
                              "Submit",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            minWidth: 100.0,
                            height: 40,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: redTheme,
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            minWidth: 100.0,
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}