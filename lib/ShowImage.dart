import 'package:flutter/material.dart';

class ShowImage extends StatefulWidget {
  final image;
  ShowImage(this.image);
  @override
  _ShowImageState createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offers"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: Image.asset(widget.image),
        ),
      ),
    );
  }
}