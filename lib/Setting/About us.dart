import 'package:flutter/material.dart';
import 'package:food_home/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  ////////////    WhatsApp Launch   //////////////////////
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.white.withOpacity(0.3), BlendMode.dstATop),
            image: AssetImage('assets/setting/main.png'),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                SizedBox(
                  height: 80.0,
                ),
                Center(
                  child: Text(
                    'Al-Madinah Food',
                    style: TextStyle(
                      color: redTheme,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "AL MADINAH FOODS provides you best Quality, Hygienic and Homemade frozen and desi stuff. We made it simpler for you to order food online and offline if you don’t want to cook. Order your favorite and desired food with just one click and enjoy your meal on your doorstep. Initially it was started a year ago and our clients are liked our food as well as our services. We delivered best healthy foods in our town. Cooked in a very clean environment with hygienic and natural masalas and ingredients. Our Frozen stuff is fully preserved and fresh. Your health is our first priority. We made it with pure things. BECAUSE PURITY MATTERS. We are providing you different foods i.e. Desi, Chinese, Deserts, Fast Food, Indian foods, Frozen stuff and many more.\n In this Pandemic our customers faced difficulties to take their order physically. So, we arranged a fully functional and dynamic food App for you. In Which You Order your desired food easily with internet. Unlike other Applications that delivered online food. We offer you ordering food offline too via MESSAGE OR CALL.\n",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      "FEATURES:\n",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                      Text("•"),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("In this app you can order your food with  different methods.",),
                      )),
                    ],),
                     Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                      Text("•"),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("It is fully functional and dynamic application."),
                      ),),
                    ],),
                      Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                      Text("•"),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("It provides you different Categorized Food Menus."),
                      ),),
                    ],),
                     Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                      Text("•"),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("It also provides you recent offers and events of Al-MADINAH FOODS."),
                      ),),
                    ],),
                     Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                      Text("•"),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("It also provides you user authentication features."),
                      ),),
                    ],),
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                      Text("•"),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("It uses different animations and transition that inspired users."),
                      ),),
                    ],),
                     Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                      Text("•"),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("It is user-friendly food application."),
                      ),),
                    ],),
                    ///   Why Us ///
                 
                    Text(
                      "\n WHY US? \n",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                      Text("o"),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("If you can’t cook. You can order us and beat your hunger",),
                      )),
                    ],),
                     Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                      Text("o"),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("When Guests accidently come and you have nothing to cook. Order our appetizing Frozen stuff."),
                      ),),
                    ],),
                      Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                      Text("o"),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("Wanna ,feel lazy to dine out ?"),
                      ),),
                    ],),
                     Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                      Text("o"),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("Wanna, enjoy Homemade taste in your Office Lunch."),
                      ),),
                    ],),
                     Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                      Text("o"),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("Wanna, try something new and different."),
                      ),),
                    ],),
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                      Text("o"),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("Using natural and healthy ingredients in our foods."),
                      ),),
                    ],),
                     Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                      Text("o"),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("Offering different discount on delivery and foods."),
                      ),),
                    ],),
                  
                    Text(
                      "\nThanks for choosing us.\n",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      "Hope you like our Services for more info may visit our social media pages and review us on GooglePlayStore.\n",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                          'assets/setting/fb.png',
                        ),
                      ),
                      onPressed: () {
                        _launchInBrowser(
                            "https://www.facebook.com/Al-madinah-Foods-102969621459551/");
                      },
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
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
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
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
      ),
    );
  }
}
