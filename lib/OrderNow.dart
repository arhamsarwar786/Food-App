import 'dart:math';
import 'package:flutter/material.dart';
import 'package:food_home/catorgry_lndngPge.dart';
import 'package:food_home/constants.dart';
import 'package:food_home/form_controller.dart';
import 'package:food_home/model.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderNowButtons extends StatefulWidget {
  final name, phone, address,email, message, listGet, finalTotal;
  OrderNowButtons(this.name, this.phone, this.address,this.email, this.message,
      [this.listGet, this.finalTotal]);
  @override
  _OrderNowButtonsState createState() => _OrderNowButtonsState();
}

class _OrderNowButtonsState extends State<OrderNowButtons> {
  var fname, lname, orderNumber;
  String dateTime;
  //////////  Init State  ////////////////
  @override
  void initState() {
    super.initState();
    initFun();
  }

  initFun() async {
    var sharePref = await SharedPreferences.getInstance();
    setState(() {
      Random random = Random();
      orderNumber = random.nextInt(1000);
      DateTime now = DateTime.now();
      dateTime = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    });
  }

  //////////    Order Via WhatsApp    ///////////////////
  launchWhatsApp() async {
    print((widget.finalTotal == null) ? widget.listGet[2] : widget.finalTotal);
    // print("$");
    var names = widget.listGet[1].toString();
    var price = widget.listGet[2].toString();

    var quantity = widget.listGet[3].toString();
    var namesAll = names.replaceAll(",", "\n");
    var priceAll = price.replaceAll(",", "\n");
    var quantityAll = quantity.replaceAll(",", "\n");

    storeDataExcel(
        widget.name,
        widget.email,
        widget.phone.toString(),
        widget.address,
        orderNumber.toString(),
        dateTime,
        namesAll,
        priceAll,
        quantityAll,
        (widget.finalTotal == null) ? widget.listGet[2][0].toString() : widget.finalTotal.toString());
    final link = WhatsAppUnilink(
      phoneNumber: "+923154031364",
      text:
          "***** Al-Madinah Food ***** \n*Thanks for ordering us* \n*Name :* ${widget.name} \n *Address :*  ${widget.address} \n *Order Number :*  $orderNumber \n\n  *....... Item's name: ........*  \n $namesAll  \n\n  *........ Unit Price .........*  \n $priceAll \n\n    *........ Quantities ........*  \n  $quantityAll   \n\n *Total price:*  ${(widget.finalTotal == null) ? widget.listGet[2] : widget.finalTotal}    .....\nYou can pay your bill via cash on delivery or jazzcash/easypaisa us on 03214031364 \n Desi Food Items Can Take 2-3 Hours.",
    );
    await launch('$link');
    var addToCart = Hive.box("addToCart");
    var addKeys = Hive.box("addKeys");
    addToCart.clear();
    addKeys.clear();
  }

  ///////////    Order Via Call    ////////////////////
  ///
  
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      var names = widget.listGet[1].toString();
      var price = widget.listGet[2].toString();
      var quantity = widget.listGet[3].toString();
      var namesAll = names.replaceAll(",", "\n");
      var priceAll = price.replaceAll(",", "\n");
      var quantityAll = quantity.replaceAll(",", "\n");

      storeDataExcel(
          widget.name,
          widget.email,
          widget.phone.toString(),
          widget.address,
          orderNumber.toString(),
          dateTime,
          namesAll,
          priceAll,
          quantityAll,
          (widget.finalTotal == null) ? widget.listGet[2][0].toString() : widget.finalTotal.toString());
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }

    var addToCart = Hive.box("addToCart");
    var addKeys = Hive.box("addKeys");
    addToCart.clear();
    addKeys.clear();
  }

  //////////////     Store Data in Excel   ////////////////////
  storeDataExcel(name, email, phoneNumber, address, orderNumber, dateTime,
      namesAll, priceAll, quantityAll, finalTotal) {
    FeedbackForm feedbackForm = FeedbackForm(name, email, phoneNumber, address,
        orderNumber, dateTime, namesAll, priceAll, quantityAll, finalTotal);
    FormController formController = FormController((String response) {
    });
    formController.submitForm(feedbackForm);
  }

  ///////////////   Send Order Via SMS    /////////////////////
  void _sendSMS() async {
    var names = widget.listGet[1].toString();
    var price = widget.listGet[2].toString();
    var quantity = widget.listGet[3].toString();
    var namesAll = names.replaceAll(",", "\n");
    var priceAll = price.replaceAll(",", "\n");
    var quantityAll = quantity.replaceAll(",", "\n");

    storeDataExcel(
        widget.name,
        widget.email,
        widget.phone.toString(),
        widget.address,
        orderNumber.toString(),
        dateTime,
        namesAll,
        priceAll,
        quantityAll,
        (widget.finalTotal == null) ? widget.listGet[2][0].toString() : widget.finalTotal.toString());

    var message =
        "***** Al-Madinah Food ***** \n*Thanks for ordering us* \n*Name :* ${widget.name} \n *Address :*  ${widget.address} \n *Order Number :*  $orderNumber \n\n  *....... Item's name: ........*  \n $namesAll  \n\n  *........ Unit Price .........*  \n $priceAll \n\n    *........ Quantities ........*  \n  $quantityAll   \n\n *Total price:*  ${(widget.finalTotal == null) ? widget.listGet[2] : widget.finalTotal}    .....\nYou can pay your bill via cash on delivery or jazzcash/easypaisa us on  03214031364 \ Desi Food Items Can Take 2-3 Hours.";
    String _result =
        await sendSMS(message: message, recipients: ["+923154031364"])
            .catchError((onError) {
      // print(onError);
    });
    // print(_result);

    var addToCart = Hive.box("addToCart");
    var addKeys = Hive.box("addKeys");
    addToCart.clear();
    addKeys.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redTheme,
        title: Text('Order Via'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 100.0,
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: redTheme,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ), //this right here
                            child: Container(
                              height: 150,
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'You will be redirect to Whatsapp Do you want to continue?',
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // ignore: deprecated_member_use
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              launchWhatsApp();
                                              Future.delayed(Duration(seconds: 2),
                                        () {
                                              disposeFun();

                                        });
                                            },
                                            // hoverColor: Colors.green,
                                            color: Colors.white,
                                            child: Text(
                                              "CONTINUE",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14),
                                            ),
                                            minWidth: 60.0,
                                            height: 35,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            // hoverColor: Colors.orange,
                                            color: Colors.white,
                                            child: Text(
                                              "CANCEL",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14),
                                            ),
                                            minWidth: 60.0,
                                            height: 35,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    'Via WHATSAPP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              Container(
                height: 100.0,
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  elevation: 10,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: redTheme,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ), //this right here
                            child: Container(
                              height: 150,
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'You will be redirect to MESSAGE Do you want to continue?',
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // ignore: deprecated_member_use
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              _sendSMS();
                                               Future.delayed(Duration(seconds: 2),
                                        () {
                                              disposeFun();

                                        });
                                            },
                                            hoverColor: Colors.green,
                                            color: Colors.white,
                                            child: Text(
                                              "CONTINUE",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14),
                                            ),
                                            minWidth: 60.0,
                                            height: 35,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            hoverColor: Colors.orange,
                                            color: Colors.white,
                                            child: Text(
                                              "CANCEL",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14),
                                            ),
                                            minWidth: 60.0,
                                            height: 35,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    'Via MESSAGE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              Container(
                height: 100.0,
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: redTheme,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ), //this right here
                            child: Container(
                              height: 150,
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'You will be redirect to CALL Do you want to continue?',
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // ignore: deprecated_member_use
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.0),
                                              ),
                                            ),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              await _makePhoneCall(
                                                  "tel: +923154031364");

                                                  Future.delayed(Duration(seconds: 2),
                                        () {
                                              disposeFun();

                                        });
                                            },
                                            hoverColor: Colors.green,
                                            color: Colors.white,
                                            child: Text(
                                              "CONTINUE",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14),
                                            ),
                                            minWidth: 60.0,
                                            height: 35,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            hoverColor: Colors.orange,
                                            color: Colors.white,
                                            child: Text(
                                              "CANCEL",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14),
                                            ),
                                            minWidth: 60.0,
                                            height: 35,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  color: Colors.blue[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    'Via CALL',
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
    );
  }
 

  disposeFun(){
    return     showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: redTheme,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ), //this right here
                            child: Container(
                              height: 150,
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Congratulation! Your Order Have Been Placed.',
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // ignore: deprecated_member_use
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.0),
                                              ),
                                            ),
                                            onPressed: () {
                                                Navigator.pushAndRemoveUntil(
                                          context,
                                          PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: LandingScreen(),

                                          ),
                                      (Route<dynamic> route) => false,
                                        );
                                            },
                                            // hoverColor: Colors.green,
                                            color: Colors.white,
                                            child: Text(
                                              "OK",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14),
                                            ),
                                            minWidth: 60.0,
                                            height: 35,
                                          ),
                                        ),
                                     
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                          });
  }
}