import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'Setting/settingmain.dart';
import 'catorgry_lndngPge.dart';
import 'constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hive/hive.dart';
import 'fav8.dart';
import 'home(menu).dart';
import 'user_details.dart';

class AddToCart extends StatefulWidget {
  final selectedItems, totalPrice;
  AddToCart([this.selectedItems, this.totalPrice]);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<AddToCart> {
  var finalTotal, total = 0, addToCart, addKeys;
  @override
  void initState() {
    super.initState();
    setState(() {
      addToCart = Hive.box("addToCart");
      addKeys = Hive.box("addKeys");
      for (var i = 0; i < addKeys.length; i++) {
        finalTotal = addToCart.get(addKeys.getAt(i));
        total += finalTotal[2][0] * finalTotal[3][0];
      }
    });
  }

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
                child: Home(),
              ),
              (Route<dynamic> route) => false,
            );
          },
        ),
        title: Text(
          "Add To Cart",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: redTheme,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
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
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:    (addKeys.length != 0)? Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemExtent: 130,
                      itemCount: addKeys.length,
                      itemBuilder: (context, i) {
                        var currentItem = addToCart.get("${addKeys.getAt(i)}");
                        return Card(
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            child: Row(children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  height: 90,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              '${currentItem[0][0]}'),
                                          fit: BoxFit.fill)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text("${currentItem[1][0]}",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'Price : ',
                                            style: TextStyle(
                                              color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            '${currentItem[2][0]}',
                                            style: TextStyle(fontSize: 20,
                                              color: Colors.orange,
                                            
                                            ),
                                          )
                                        ],
                                      ),

                                      /////    Increament and Decement with Delete Item //////
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: redTheme,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                                onPressed: () async {
                                                  setState(() {
                                                    currentItem[3][0] =
                                                        currentItem[3][0] + 1;

                                                    total = total +
                                                        currentItem[2][0];
                                                  });
                                                },
                                              ),
                                            ),

                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child:
                                                  Text("${currentItem[3][0]}"),
                                            ),
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: redTheme,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                                onPressed: () {
                                                  setState(
                                                    () {
                                                      if (currentItem[3][0] ==
                                                          1) {
                                                        currentItem[3][0];
                                                      } else {
                                                        currentItem[3][0] =
                                                            currentItem[3][0] -
                                                                1;

                                                        setState(() {
                                                          total = total -
                                                              currentItem[2][0];
                                                        });
                                                      }
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  addToCart
                                                      .delete("$currentItem");
                                                  addKeys.deleteAt(i);
                                                  total = total -
                                                      (currentItem[3][0] *
                                                          currentItem[2][0]);
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
                                                          " '${currentItem[1][0]}' Removed",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });

                                              },
                                              color: redTheme,
                                              icon: Icon(
                                                Icons.delete_outline_rounded,
                                                size: 35.0,
                                                color: redTheme,
                                              ),
                                             
                                            ),
                                            // ignore: deprecated_member_use
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        );
                      }),
                ),
                Builder(
                  builder: (context) {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Total =  $total ",
                            style: TextStyle(fontSize: 20),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 10.0,
                            hoverColor: Colors.black,
                            color: redTheme,
                            onPressed: () {
                              if (addKeys.length == 0) {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: redTheme,
                                    content: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        " Add Any Item Into Cart",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                var myList = [[], [], [], []];
                                for (var i = 0; i < addKeys.length; i++) {
                                  var res = addToCart.get(addKeys.getAt(i));
                                  myList[0].add(res[0][0]);
                                  myList[1].add(res[1][0]);
                                  myList[2].add(res[2][0]);
                                  myList[3].add(res[3][0]);                                
                                }
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: UserDetail(myList, total),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'BUY NOW',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ]):Center(child: Text("No Item Added into Cart ")),
        ),
      ),
    );
  }
}
