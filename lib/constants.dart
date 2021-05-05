import 'package:flutter/material.dart';

const Color redTheme = Color(0xffA02621);
const Color yela1 = Colors.yellowAccent;
const Color yelo2 = Colors.yellow;
const Gradient redT = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xffA02621), Color(0xff4b0205)]);

class CONTAINER extends StatelessWidget {
  CONTAINER(
      {this.child,
      this.height,
      this.width,
      this.color,
      this.border,
      this.borderRadius,
      this.margin,
      this.gradient,
      this.alignment,
      this.padding,
      this.image});
  final child;
  final double width;
  final double height;
  final color;
  final border;
  final borderRadius;
  final margin;
  final padding;
  final alignment;
  final gradient;
  final image;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      margin: margin,
      padding: padding,
      clipBehavior: Clip.hardEdge,
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        image: image,
        color: color,
        border: border,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}
