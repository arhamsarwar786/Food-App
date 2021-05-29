import 'package:flutter/material.dart';
import 'package:food_home/constants.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'HistoryRecord.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var hKeys, hValues;
  @override
  void initState() {
    super.initState();
    hKeys = Hive.box("hKeys");
    hValues = Hive.box("hValues");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Order History"),),
        body: (hKeys.length != 0)
            ? Container(
                child: ListView.builder(
                  itemCount: hKeys.length,
                  itemBuilder: (context, i) {
                    var z = i + 1;

                    return Container(
                      width: MediaQuery.of(context).size.width,
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        height: 100,
                        onPressed: () {
                            Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeftWithFade,
                                              child: HistoryRecord(hKeys.getAt(i)),
                                            ),
                            );},
                                  
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Text(
                            "$z-          ${hKeys.getAt(i)}",
                            style: TextStyle(fontSize: 20, color: redTheme),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : Center(
                child: Text("Oops! you have no recent Order History!"),
              ));
  }
}
