import 'package:flutter/material.dart';
import 'user_details.dart';
import 'constants.dart';
import 'package:slimy_card/slimy_card.dart';
import 'Add to cart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';

class CardDetails extends StatefulWidget {
  final image, name, price, desc, recentStore;
  CardDetails(this.image, this.name, this.price, this.desc, [this.recentStore]);
  @override
  _CardDetailsState createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  List selectedItem = [];
  List allKeysList = [];
  var myList = [[], [], [], []];
  var addToFav = [[], [], [], []];
  var favBox, addToCart;
  var allKeys, addKeys;

  @override
  void initState() {
    super.initState();
    favBox = Hive.box("favBox");
    allKeys = Hive.box("allKeys");
    addToCart = Hive.box("addToCart");
    addKeys = Hive.box("addKeys");
  }

  addItemFun(BuildContext context) async {
    var addToCart = Hive.box("addToCart");
    var addKeys = Hive.box("addKeys");
    for (var i = 0; i < addKeys.length; i++) {
      var res = addToCart.get(addKeys.getAt(i));
      myList[0].add(res[0][0]);
      myList[1].add(res[1][0]);
      myList[2].add(res[2][0]);
      myList[3].add(res[3][0]);
    }
    if (addKeys.length == 0) {
      await addToCart.put("${widget.name}", [
        [widget.image[0]],
        [widget.name],
        [widget.price],
        [1]
      ]);
      await addKeys.add(widget.name);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("${widget.name} Added into Favorite")));
    } else {
      if (myList[1].contains(widget.name)) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("Already Added into Cart")));
      } else {
        if (addKeys.length != 0) {
          await addToCart.put("${widget.name}", [
            [widget.image[0]],
            [widget.name],
            [widget.price],
            [1]
          ]);
          await addKeys.add(widget.name);
        }
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
          "${widget.name}",
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(size);
    return Scaffold(
      appBar: AppBar(
        shadowColor: redTheme,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, [widget.recentStore]);
          },
          icon: Icon(
            Icons.arrow_back,
            color: redTheme,
          ),
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
                      type: PageTransitionType.leftToRight, child: AddToCart()),
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
          "Item Details",
          style: TextStyle(
            color: redTheme,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: SlimyCard(
                color: redTheme,
                width: size.width,
                topCardHeight: size.height * 0.35,
                bottomCardHeight: size.height * 0.40,
                borderRadius: 15,
                topCardWidget:
                    topCardWidget(widget.image, size.width, size.height * 0.4),
                bottomCardWidget: bottomCardWidget(),
                slimeEnabled: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Recently Viewed",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: size.width,
              height: 165,
              child: item(),
            ),
          ],
        ),
      ),
    );
  }

  Widget item() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: widget.recentStore[2].length,
      itemBuilder: (BuildContext context, int index) {
        index =(widget.recentStore[2].length-1) -index; 
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: CardDetails(
                    widget.recentStore[0][index],
                    widget.recentStore[2][index],
                    widget.recentStore[1][index],
                    widget.recentStore[3][index],
                    widget.recentStore),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(left: 10),
            width: 155,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  image: AssetImage("${widget.recentStore[0][index][0]}"),
                  fit: BoxFit.cover),
              border: Border.all(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(30),
            ),
            height: 200,
          ),
        );
      },
    );
  }

  Widget topCardWidget(List imagePath, var width, var height) {
    var size = MediaQuery.of(context).size;
    List<dynamic> images;
    setState(() {
      images = imagePath;
    });
    return Container(
      height: height,
      width: width,
      child: CarouselSlider(
          options: CarouselOptions(
            height: size.height / 3,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: images.map((i) {
            return Builder(builder: (BuildContext context) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange, width: 2),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage(
                          i,
                        ),
                        fit: BoxFit.cover),
                  ));
            });
          }).toList()),
      decoration: BoxDecoration(
        color: redTheme,
        borderRadius: BorderRadius.circular(15),

        //
      ),
    );
  }

  // This widget will be passed as Bottom Card's Widget.
  Widget bottomCardWidget() {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.name}",
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width < 300 ? 15 :20,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Price: ${widget.price}",
              style: TextStyle(
                color: Colors.orange[200],
                fontSize: MediaQuery.of(context).size.width < 300 ? 15 :20,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "${widget.desc}",
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width < 300 ? 10 :14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      /////    Added to Fav   //////
                      for (var i = 0; i < allKeys.length; i++) {
                        var res = favBox.get(allKeys.getAt(i));
                        addToFav[0].add(res[0][0]);
                        addToFav[1].add(res[1][0]);
                        addToFav[2].add(res[2][0]);
                        addToFav[3].add(res[3][0]);
                      }
                      if (allKeys.length == 0) {
                        await favBox.put("${widget.name}", [
                          [widget.image[0]],
                          [widget.name],
                          [widget.price],
                          [1]
                        ]);
                        var data = await allKeys.add(widget.name);

                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("${widget.name}")));
                      } else {
                        if (addToFav[1].contains(widget.name)) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Already Added into Cart")));
                        } else {
                          if (allKeys.length != 0) {
                            await favBox.put("${widget.name}", [
                              [widget.image[0]],
                              [widget.name],
                              [widget.price],
                              [1]
                            ]);
                            var data = await allKeys.add(widget.name);
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                              "${widget.name}",
                            )));
                          }
                        }
                      }
                    },
                    color: redTheme,
                    icon: Icon(
                      Icons.favorite,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    onPressed: () {
                      setState(() {
                        addItemFun(context);
                      });
                    },
                    color: Colors.orange,
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    minWidth: 60.0,
                    height: 35,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    onPressed: () {
                      var buyNow = [[], [], [], []];
                      buyNow[0].add(widget.image);
                      buyNow[1].add(widget.name);
                      buyNow[2].add(widget.price);
                      buyNow[3].add(1);
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: UserDetail(buyNow),
                        ),
                      );
                    },
                    color: Colors.orange,
                    child: Text(
                      "Buy Now",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    minWidth: 60.0,
                    height: 35,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}






    //  PHP 7 ,Laravel , Node Js , JSP, Django ,flask
    // 
    // DataBase (SQL, Non-SQL)
    // 
    //  To Connect with Server 