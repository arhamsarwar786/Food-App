import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:food_home/Setting/settingmain.dart';
import 'package:hive/hive.dart';
import 'catorgry_lndngPge.dart';
import 'constants.dart';
import 'fav8.dart';
import 'json.dart';
import 'Add to cart.dart';
import 'card_details.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:page_transition/page_transition.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Home extends StatefulWidget {
  final keyGet, indexGet;
  Home([
    this.keyGet,
    this.indexGet,
  ]);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List listGet = [[], [], [], []], searchList = [];
  var indexNew = 0, keyNew = 'FROZEN';
  var totalPrice = 0;
  List recentStore = [[], [], [], []];
  var ctrgy = "FROZEN", ctrgyIndex = 0, selectedColor = Color(0xffA05446);
  int _selectedIndex = 0;
  List<bool> isSelected;

  String dataInput;

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
            type: PageTransitionType.leftToRight,
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
        selectedColor = redTheme;

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

  var selected;
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  Widget textfield() {
    return AutoCompleteTextField(
      itemSubmitted: (item) {
        setState(() {
          var indexNew1 = 0, keyNew1 = 'FROZEN';
          for (var i = 0; i < 3; i++) {
            for (var j = 0; j < items[i][keyNew1].length; j++) {
              if (item == items[i][keyNew1][j][0]) {
                var image = items[i][keyNew1][j][3];
                var price = items[i][keyNew1][j][1];
                var name = items[i][keyNew1][j][0];
                var desc = items[i][keyNew1][j][2];

                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: CardDetails(image, name, price, desc, recentStore),
                  ),
                );
              } else {
                // print("Nothing  ");
              }
            }
            indexNew1++;
            if (indexNew1 == 0) {
              keyNew1 = "FROZEN";
            } else if (indexNew1 == 1) {
              keyNew1 = "DESI FOOD DEAL";
            } else if (indexNew1 == 2) {
              keyNew1 = "FAST FOOD";
            }
          }
        });
      },
      key: key,
      suggestions: searchList,
      itemBuilder: (context, suggestion) => suggestion == dataInput ? Padding(
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: redTheme)),
          child: ListTile(
            title: Text("No Item Found"),
          ),
        ),
        padding: EdgeInsets.all(8.0),
      ): Padding(
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: redTheme)),
          child: ListTile(
            title: Text(suggestion),
          ),
        ),
        padding: EdgeInsets.all(8.0),
      ),
      itemSorter: (a, b) => a.compareTo(b),
      itemFilter: (suggestion, input) {
          dataInput = input;
        return  suggestion.toLowerCase().startsWith(input.toLowerCase());},
      decoration: InputDecoration(
        hintText: "Search here",
        fillColor: redTheme,
        focusColor: redTheme,
        prefixIcon: Icon(
          Icons.search,
          color: redTheme,
          size: 30.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  List myList = [];

  initFun() {
    List.generate(items[0]["FROZEN"].length, (index) {
      for (var i = 0; i < items[index]["FROZEN"].length; i++) {
        myList.add(items[index]["FROZEN"][i][0]);
        myList = myList.toSet().toList();
      }
    });
  }

  List selectedItem = [];
  List allKeysList = [];
  var mList = [[], [], [], []];
  var addToFav = [[], [], [], []];
  var favBox;
  var allKeys;

  @override
  void initState() {
    // initFun();
    super.initState();
    favBox = Hive.box("favBox");
    allKeys = Hive.box("allKeys");

    setState(() {
      isSelected = [false, false, false];
      for (var i = 0; i < 3; i++) {
        for (var j = 0; j < items[i][keyNew].length; j++) {
          searchList.add(items[i][keyNew][j][0]);
        }
        indexNew++;
        if (indexNew == 0) {
          keyNew = "FROZEN";
        } else if (indexNew == 1) {
          keyNew = "DESI FOOD DEAL";
        } else if (indexNew == 2) {
          keyNew = "FAST FOOD";
        }
      }
    });
  }

  // addItemFun(BuildContext context) async {
  //   var favBox = Hive.box("favBox");
  //   var allKeys = Hive.box("allKeys");
  //   for (var i = 0; i < allKeys.length; i++) {
  //     var res = favBox.get(allKeys.getAt(i));
  //     myList[0].add(res[0][0]);
  //     myList[1].add(res[1][0]);
  //     myList[2].add(res[2][0]);
  //     myList[3].add(res[3][0]);
  //   }
  //   if (allKeys.length == 0) {
  //     await favBox.put("${widget.name}", [
  //       [widget.image[0]],
  //       [widget.name],
  //       [widget.price],
  //       [1]
  //     ]);
  //     await allKeys.add(widget.name);
  //     Scaffold.of(context).showSnackBar(
  //         SnackBar(content: Text("${widget.name} Added into Favorite")));
  //   } else {
  //     if (myList[1].contains(widget.name)) {
  //       Scaffold.of(context)
  //           .showSnackBar(SnackBar(content: Text("Already Added into Cart")));
  //     } else {
  //       if (allKeys.length != 0) {
  //         await favBox.put("${widget.name}", [
  //           [widget.image[0]],
  //           [widget.name],
  //           [widget.price],
  //           [1]
  //         ]);
  //         await allKeys.add(widget.name);
  //       }
  //       Scaffold.of(context).showSnackBar(SnackBar(
  //           content: Text(
  //         "${widget.name}",
  //       )));
  //     }
  //   }
  // }

  bool isFilled = true;
  toggleMethod() {
    setState(() {
      isFilled = !isFilled;
    });
  }

  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);

    List myKeys = [];
    for (int i = 0; i < items.length; i++) {
      var keys = items[i].keys;
      myKeys.add(keys.elementAt(0));
    }

    return ModalProgressHUD(
      progressIndicator: CircularProgressIndicator(
        backgroundColor: redTheme,
        strokeWidth: 2,
      ),
      inAsyncCall: isSaved,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: redTheme,
              ),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());

                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: LandingScreen(),
                  ),
                );
              },
            ),
            shadowColor: redTheme,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
                // color: Colors.white,
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
                        type: PageTransitionType.leftToRight,
                        child: AddToCart(),
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
              "Menu",
              style: TextStyle(
                color: redTheme,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 1,
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
            child: Column(
              children: [
                /***************************UPPER COONTAINER *********/
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: textfield(),
                ),
                SizedBox(
                  height: 4.0,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 50.0,
                    decoration: BoxDecoration(),
                    child: ToggleButtons(
                      selectedColor: redTheme,
                      fillColor: Colors.transparent,
                      borderColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      borderWidth: 0,
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "FROZEN",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "DESI FOOD DEAL",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "FAST FOOD",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      onPressed: (myIndex) {
                        setState(() {
                          ctrgyIndex = myIndex;
                          ctrgy = myKeys[myIndex];
                          for (int i = 0; i < isSelected.length; i++) {
                            isSelected[i] = i == myIndex;
                          }
                        });
                      },
                      isSelected: isSelected,
                    ),
                  ),
                ),
                Divider(color: redTheme),
                /****************************Items GRID CONTAINER****************/
                Expanded(
                  child: Container(
                    child: StaggeredGridView.countBuilder(
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.count(
                        1,
                        (MediaQuery.of(context).size.width > 400) ? 1.3 : 1.4,
                      ),
                      crossAxisCount: 2,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: items[ctrgyIndex][ctrgy].length,
                      padding: EdgeInsets.only(top: 20, right: 12, left: 12),
                      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,

                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          onTap: () async {
                            setState(() {
                              isSaved = true;
                            });
                            var image = items[ctrgyIndex][ctrgy][index][3];
                            var price = items[ctrgyIndex][ctrgy][index][1];
                            var name = items[ctrgyIndex][ctrgy][index][0];
                            var desc = items[ctrgyIndex][ctrgy][index][2];
                            if (recentStore[0].contains(image)) {
                            } else {
                              recentStore[0].add(image);
                              recentStore[1].add(price);
                              recentStore[2].add(name);
                              recentStore[3].add(desc);
                            }
                            Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                isSaved = false;
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    child: CardDetails(
                                        image, name, price, desc, recentStore),
                                  ),
                                );
                              });
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: redTheme, width: 1),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(3, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    // width: 175,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "${items[ctrgyIndex][ctrgy][index][3][0]}"),
                                          fit: BoxFit.cover),
                                      // border:
                                      // Border.all(color: redTheme, width: 1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                    ),
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        top:
                                            (MediaQuery.of(context).size.width >
                                                    450)
                                                ? 40.0
                                                : 10,
                                        bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${items[ctrgyIndex][ctrgy][index][0]}",
                                          style: TextStyle(
                                              fontSize: (MediaQuery.of(context)
                                                          .size
                                                          .width >
                                                      450)
                                                  ? 20.0
                                                  : 13,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Price: ${items[ctrgyIndex][ctrgy][index][1]}",
                                              style: TextStyle(
                                                  fontSize:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .width >
                                                              450)
                                                          ? 27.0
                                                          : 17,
                                                  color: redTheme,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                toggleMethod();
                                                for (var i = 0;
                                                    i < allKeys.length;
                                                    i++) {
                                                  var res = favBox
                                                      .get(allKeys.getAt(i));
                                                  addToFav[0].add(res[0][0]);
                                                  addToFav[1].add(res[1][0]);
                                                  addToFav[2].add(res[2][0]);
                                                  addToFav[3].add(res[3][0]);
                                                }
                                                  print("this is AddTOFav $addToFav");
                                                print("this is the Item Added Keys : ${items[ctrgyIndex][ctrgy][index]}");
                                                if (allKeys.length == 0) {
                                                  await favBox.put(
                                                      "${items[ctrgyIndex][ctrgy][index][0]}",
                                                      [ 
                                                        [
                                                          "${items[ctrgyIndex][ctrgy][index][3][0]}"
                                                        ],
                                                        [
                                                          "${items[ctrgyIndex][ctrgy][index][0]}"
                                                        ],
                                                        [
                                                          "${items[ctrgyIndex][ctrgy][index][1]}"
                                                        ],
                                                        [1]
                                                      ]);

                                                  await allKeys.add(
                                                      items[ctrgyIndex][ctrgy]
                                                          [index][0]);

                                                  Scaffold.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "${items[ctrgyIndex][ctrgy][index][0]}")));
                                                } else {
                                                    print("this Item have : $addToFav");
                                                  if (addToFav[1].contains(
                                                      items[ctrgyIndex][ctrgy]
                                                          [index][0])) {
                                                    favBox.delete(
                                                        allKeys.getAt(index));
                                                    allKeys.deleteAt(index);
                                                    Scaffold.of(context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "REMOVED into Cart")));
                                                    print("delete this Item :    $addToFav");
                                                  } else {
                                                    if (allKeys.length != 0) {
                                                      await favBox.put(
                                                          "${items[ctrgyIndex][ctrgy][index][0]}",
                                                          [
                                                            [
                                                              "${items[ctrgyIndex][ctrgy][index][3][0]}"
                                                            ],
                                                            [
                                                              "${items[ctrgyIndex][ctrgy][index][0]}"
                                                            ],
                                                            [
                                                              "${items[ctrgyIndex][ctrgy][index][1]}"
                                                            ],
                                                            [1]
                                                          ]);
                                                      await allKeys
                                                          .add(items[ctrgyIndex]
                                                                  [ctrgy][index]
                                                              [0]);
                                                      Scaffold.of(context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                                  content: Text(
                                                        "${items[ctrgyIndex][ctrgy][index][0]}",
                                                      )));
                                                    }
                                                  }
                                                }
                                                // print(items[ctrgyIndex][ctrgy]);
                                              },

                                              color: redTheme,
                                              icon: isFilled
                                                  ? Icon(
                                                      Icons.favorite_outline,
                                                    )
                                                  : Icon(
                                                      Icons.favorite,
                                                      // size: 40,
                                                    ),
                                              // Icon(Icons.favorite_outline),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
