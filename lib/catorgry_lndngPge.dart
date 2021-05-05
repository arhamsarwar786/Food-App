import 'package:flutter/material.dart';
import 'package:food_home/login.dart';
import 'package:food_home/signup.dart';
import 'package:food_home/user_details.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'ShowImage.dart';
import 'constants.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'json.dart';
import 'Add to cart.dart';
import 'fav8.dart';
import 'home(menu).dart';
import 'Setting/settingmain.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List listGet = [[], [], [], []];
  List images = [
    'assets/images/banner1.jpeg',
    'assets/images/banner2.jpeg',
    'assets/images/banner3.jpeg',
  ];

  List drw = ['Favorite', 'Add to Cart', 'Setting', 'Contact Us','Share'];
  List drawerIcons = [
    Icons.favorite,
    Icons.shopping_cart,
    Icons.settings,
    Icons.phone,
    Icons.share
  ];
  bool isSaved = false;
  var ctrgy = "FROZEN", ctrgyIndex;
  int _selectedIndex = 0;



    Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {


    
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }


  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: LandingScreen(),
          ),
          // (Route<dynamic> route) => false,
        );
      } else if (_selectedIndex == 1) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: Home(),
          ),
        );
      } else if (_selectedIndex == 2) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: FavoriteScreen(),
          ),
          // (Route<dynamic> route) => false,
        );
      } else if (_selectedIndex == 3) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: AddToCart(),
          ),
          // (Route<dynamic> route) => false,
        );
      } else if (_selectedIndex == 4) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: Setting(),
          ),
          // (Route<dynamic> route) => false,
        );
      } else {
        return LandingScreen();
      }
    });
  }

  var fname, lname, randomNumber;
  @override
  void initState() {
    initFun();
    super.initState();
  }

  initFun() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      fname = sharedPreferences.getString("fname");
      lname = sharedPreferences.getString("lname");
    });
  }

  @override
  Widget build(BuildContext context) {
    List myKeys = [];

    for (int i = 0; i < items.length; i++) {
      var keys = items[i].keys;
      myKeys.add(keys.elementAt(0));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      //*************************APPBAR***********/
      appBar: AppBar(
        shadowColor: redTheme,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: redTheme,
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: AddToCart(listGet),
                  ),
                );
              },
              icon: Icon(
                Icons.shopping_cart,
                size: 30,
                color: redTheme,
              ),
            ),
          )
        ],
        title: Text(
          "Welcome",
          style: TextStyle(
            color: redTheme,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      //****************************DRAWER****************/
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(40.0)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: redT,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                          bottom: 30.0,
                        ),
                        child: Text(
                          "$fname $lname",
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 2.0,
            ),
            // ignore: deprecated_member_use
            Expanded(
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: drw.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // ignore: deprecated_member_use
                      return ListTile(
                        leading: Icon(
                          drawerIcons[index],
                          color: redTheme,
                        ),
                        onTap: () {
                          if (index == 0)
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: FavoriteScreen(),
                              ),
                            );
                          else if (index == 1)
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: AddToCart(),
                              ),
                            );
                          else if (index == 2)
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: Setting(),
                              ),
                            );
                          else if (index == 3){
                                  _makePhoneCall("tel:+923154031364");

                          }
                           if (index == 4)
                            Share.share("https://play.google.com/store/apps/details?id=com.almadinahfoods.food_app1");
                         
                        },
                        title: Text(
                          '${drw[index]}',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      );
                    },
                  ),
                  (fname == "Guest#")
                      ? Container(
                        margin: EdgeInsets.only(top:5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 20),
                              Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: redTheme, width: 2)),
                                child: MaterialButton(
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
                                  child: Text(
                                    "LogIn",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                height: 40,
                                width: 80,
                                child: MaterialButton(
                                  color: redTheme,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.leftToRight,
                                        child: Signup(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "SignUp",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                        margin: EdgeInsets.only(top:5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 20),
                              Container(
                                height: 40,
                                width: 80,
                                child: MaterialButton(
                                  color: redTheme,
                                  onPressed: () {
                                    setState(() {
                                      isSaved = true;
                                    });
                                    Future.delayed(Duration(milliseconds: 500),
                                        () {
                                      setState(() {
                                        isSaved = false;
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: Login(),
                                          ),
                                        );
                                      });
                                    });
                                  },
                                  child: Text(
                                    "LogOut",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 40,
                    child: FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(
                          'assets/setting/fb.png',
                        ),
                      ),
                      onPressed: () {
                        //////////////////   FACEBOOK      ///////////////////////
                        _launchInBrowser(
                            "https://www.facebook.com/Al-madinah-Foods-102969621459551/");
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    child: FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(
                          'assets/setting/ins.png',
                        ),
                      ),
                      onPressed: () {
                        _launchInBrowser(
                            "https://instagram.com/foodsalmadinah?igshid=1twszt6r78ovj/");
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    child: FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(
                          'assets/setting/whts.png',
                        ),
                      ),
                      onPressed: () async {
                        var link = WhatsAppUnilink(
                          phoneNumber: "+923154031364",
                        );    
                        await launch('$link');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //***************************BODY*************/
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
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.30,

                    margin: EdgeInsets.only(top: 50),
                    width: MediaQuery.of(context).size.width,
                    child: CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1.0,
                          aspectRatio: 16 / 10,
                          autoPlay: true,
                        ),
                        items: images.map((i) {
                          return Builder(builder: (BuildContext context) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.topToBottom,
                                    child: ShowImage(i),
                                  ),
                                );
                              },
                              child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 2),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: redTheme, width: 3),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: AssetImage(
                                          i,
                                        ),
                                        fit: BoxFit.fill),
                                  )),
                            );
                          });
                        }).toList()),
                  ),
                  Expanded(
                    // height: MediaQuery.of(context).size.height * 0.30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Explore",
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: redTheme,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    "We will provide you pure and hygenic food",
                                    style: TextStyle(
                                        fontSize: 18, color: redTheme)),
                                Row(
                                  children: [
                                    Text(
                                      "Order now ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.orange[900]),
                                    ),
                                    Text(
                                      " to beat your hunger.",
                                      style: TextStyle(
                                          color: redTheme, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(     
                          margin: EdgeInsets.only(top: 10),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                               decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                                    ),                              
                              constraints: BoxConstraints(
                                  maxWidth: 200.0, minHeight: 50.0),
                              margin: EdgeInsets.all(10),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                onPressed: () {
                                  setState(() {
                                isSaved = true;                                    
                                  });
                                  Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                isSaved = false;
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    child:Home(),
                                  ),
                                );
                              });
                            });
                                },
                                color: redTheme,
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Continue',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      //**************************BOTTOM NAVIGATION BAR********/
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: _onItemTapped,
        iconSize: 30,
        selectedLabelStyle: TextStyle(
          color: redTheme,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.black12,
        ),
        selectedItemColor: redTheme,
        unselectedFontSize: 15.0,
        selectedIconTheme: IconThemeData(color: redTheme),
        unselectedIconTheme: IconThemeData(color: Colors.black12),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            // ignore: deprecated_member_use
            title: Text(
              "Home",
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
            ),
            // ignore: deprecated_member_use
            title: Text(
              "Menu",
              // style: TextStyle(color: yelo2),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            // ignore: deprecated_member_use
            title: Text(
              "Favorite",
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            // ignore: deprecated_member_use
            title: Text(
              "Cart",
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            // ignore: deprecated_member_use
            title: Text(
              "Setting",
            ),
          ),
        ],
      ),
    );
  }
}
