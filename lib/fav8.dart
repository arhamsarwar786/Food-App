import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'Add to cart.dart';
import 'Setting/settingmain.dart';
import 'constants.dart';
import 'catorgry_lndngPge.dart';
import 'home(menu).dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';

int indeX = 5;

class FavoriteScreen extends StatefulWidget {
  final _selectedIndex;
  FavoriteScreen([this._selectedIndex]);
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  var favBox;
  var valueGetHive;

  var allKeys;

  @override
  void initState() {
    super.initState();

    favBox = Hive.box("favBox");
    allKeys = Hive.box("allKeys");
  }

  int _selectedIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    // favBox.put("favKey", "Arham");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: Home(),
              ),
              (Route<dynamic> route) => false,
            );
          },
        ),
        backgroundColor: redTheme,
        title: Text("FAVORITE"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
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
              // style: TextStyle(color: yelo2),
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
              // style: const TextStyle(color: Colors.white),
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
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: (allKeys.length != 0)? ListView.builder(
          itemCount: allKeys.length,
          itemBuilder: (BuildContext context, int index) {
            var currentItem = favBox.get("${allKeys.getAt(index)}");
            return Card(
              child: Container(
                height: 112,
                padding: const EdgeInsets.all(0),
                child: Row(children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('${currentItem[0][0]}'),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 14,
                    child: Container(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${currentItem[1][0]}",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Price : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.orange),
                              ),
                              Text(
                                '${currentItem[2][0]}',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.orange),
                              ),
                            ],
                          ),
                          /////    Favorite Remove Item       //////                        
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.redAccent[700],
                                    size: 20,
                                  ),
                                  onTap: () {
                                    setState(
                                      () {
                                        favBox.delete("${currentItem[1][0]}");
                                        allKeys.deleteAt(index);
                                      },
                                    );
                                  },
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MaterialButton(
                                      onPressed: () async {
                                        var addToCart = Hive.box("addToCart");
                                        var addKeys = Hive.box("addKeys");

                                       var checkList = [];
                                for (var i = 0; i < addKeys.length; i++) {
                                  var res = addToCart.get(addKeys.getAt(i));
                                  checkList.add(res[1][0]);              
                                  print("this is CheckList : $checkList");
                                }
                                if(checkList.contains(currentItem[1][0])){

                                   Scaffold.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      backgroundColor: redTheme,
                                                      content: Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Text(
                                                          " Already Added into Cart",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  );

                                }else{
                                    await addToCart.put(
                                            "${currentItem[1][0]}",
                                            currentItem);
                                        await addKeys.add(currentItem[1][0]);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddToCart(),),);
                                }
                                      // );
                                      },
                                      color: redTheme,
                                      child: Center(
                                          child: Text(
                                        "ADD TO CARD",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            );
          },
        ):Center(child: Text("No Item Added into Favorite")),
      ),
    );
  }
}
