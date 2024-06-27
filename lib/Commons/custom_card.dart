// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget childWidget;
  final double width;
  final double height;
  final bool? isBackground;
  final String? imageUrl;
  final BorderRadius borderRadius;
  const CustomCard(
      {super.key,
      required this.childWidget,
      required this.width,
      required this.height,
      this.isBackground = false,
      this.imageUrl,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: isBackground!
              ? DecorationImage(image: AssetImage(imageUrl!), fit: BoxFit.cover)
              : null,
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(211, 209, 216, 0.30),
                offset: Offset(5, 10),
                blurRadius: 20)
          ],
          color: Colors.white),
      child: childWidget,
    );
  }
}
