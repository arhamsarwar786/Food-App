import 'package:food_home/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import '../Add to cart.dart';
import '../catorgry_lndngPge.dart';
import '../fav8.dart';
import '../home(menu).dart';
import 'Profile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'About us.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var status = false;

  var _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: LandingScreen(),
          ),
          (Route<dynamic> route) => false,
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
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: FavoriteScreen(),
          ),
          (Route<dynamic> route) => false,
        );
      } else if (_selectedIndex == 3) {
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: AddToCart(),
          ),
          (Route<dynamic> route) => false,
        );
      } else if (_selectedIndex == 4) {
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: Setting(),
          ),
          (Route<dynamic> route) => false,
        );
      } else {
        return LandingScreen();
      }
    });
  }

  Future<void>_launchInBrowser(String url) async {
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

  var fname, lname;
  @override
  void initState() {
    super.initState();
    initFun();
  }

  initFun() async {
    var sharePref = await SharedPreferences.getInstance();
    fname = sharePref.getString("fname");
    lname = sharePref.getString("lname");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: Home(),
              ),
              (Route<dynamic> route) => false,
            );
          },
        ),
        // toolbarHeight: 70,
        backgroundColor: redTheme,
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backwardsCompatibility: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
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
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: ListTile(
                title: Text("Clear Favorate's "),
                subtitle:
                    Text("Press Button Automatically Remove your Saved Items "),
                trailing: SizedBox(
                  height: 30,
                  width: 30,
                  child: FloatingActionButton(
                    backgroundColor: redTheme,
                    child: Icon(
                      Icons.delete,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: redTheme,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                height: 150,
                                width: 150,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Do you want to remove all items from FAVORITE?',
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
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0),
                                                ),
                                              ),
                                              onPressed: () {
                                                var favBox = Hive.box("favBox");
                                                var allKeys =
                                                    Hive.box("allKeys");
                                                favBox.clear();
                                                allKeys.clear();

                                                Navigator.pop(context);
                                              },
                                              hoverColor: Colors.orange,
                                              color: Colors.white,
                                              child: Text(
                                                "YES",
                                                style: TextStyle(
                                                    color: redTheme,
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
                                                "NO",
                                                style: TextStyle(
                                                    color: redTheme,
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
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Clear Add to Cart "),
                subtitle:
                    Text("Press Button Automatically Remove your Saved Items "),
                trailing: SizedBox(
                  height: 30,
                  width: 30,
                  child: FloatingActionButton(
                    backgroundColor: redTheme,
                    child: Icon(
                      Icons.delete,
                    ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Do you want to remove all items from ADD TO CART?',
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
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0),
                                                ),
                                              ),
                                              onPressed: () {
                                                var addToCart =
                                                    Hive.box("addToCart");
                                                var addKeys =
                                                    Hive.box("addKeys");
                                                addToCart.clear();
                                                addKeys.clear();
                                                Navigator.pop(context);
                                              },
                                              hoverColor: Colors.orange,
                                              color: Colors.white,
                                              child: Text(
                                                "YES",
                                                style: TextStyle(
                                                    color: redTheme,
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
                                                "NO",
                                                style: TextStyle(
                                                    color: redTheme,
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
                  ),
                ),
              ),
            ),
            // ignore: deprecated_member_use
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: (fname == "Guest#") ? ProfileGuest() : ProfileUser(),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  title: Text("PROFILE "),
                  trailing: SizedBox(
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                   _launchInBrowser(
                            "https://play.google.com/store/apps/details?id=com.almadinahfoods.food_app1");
              },
              child: Card(
                child: ListTile(
                  title: Text("RATE US "),
                  subtitle: Text("Give your honest Review"),
                  trailing: SizedBox(
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ),
            // ignore: deprecated_member_use
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: About(),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  title: Text("ABOUT US"),
                  subtitle: Text("Al-madinah Food "),
                  // ignore: deprecated_member_use
                  trailing: SizedBox(
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.dstATop),
                    image: AssetImage('assets/setting/img.jpg'),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 80.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FloatingActionButton(
                          backgroundColor: Colors.transparent,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(
                              'assets/setting/fb.png',
                            ),
                          ),
                          onPressed: () {
                            //////////////////   FACEBOOK      ///////////////////////
                            ///
                            _launchInBrowser(
                                "https://www.facebook.com/Al-madinah-Foods-102969621459551/");
                          },
                        ),
                        FloatingActionButton(
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
                        FloatingActionButton(
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
                      ],
                    ),
                    Text(
                      '/almadinahfood',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
