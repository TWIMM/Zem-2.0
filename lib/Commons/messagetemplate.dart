// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:agri_market/Commons/custom_text.dart';

class CustomMessage extends StatelessWidget {
  final bool? isBackground;
  final String imageUrl;
  final int numberofunread;
  final String message;
  final String sender;

  const CustomMessage({
    super.key,
    required this.numberofunread,
    required this.message,
    this.isBackground = false,
    required this.sender,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
          width: deviceWidth * 0.9,
          height: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white, // Set the background color of the container
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              width: 65,
              child: Image.asset(
                imageUrl,
                width: 60, // Set the desired width
                height: 60, // Set the desired height
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              width: deviceWidth * 0.60,
              height: 80,
              child: _buildannoncetext(message),
            ),
            Container(width: 30, child: _builnumberofunraead(numberofunread))
          ])),
    );
  }

  Widget _buildannoncetext(description) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
        height: 15,
      ),
      StyledText(
        text: sender,
        fontName: "Open Sans",
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      SizedBox(
        height: 10,
      ),
      StyledText(
        text: message,
        fontName: "Open Sans",
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      SizedBox(
        height: 10,
      ),
    ]);
  }

  Widget _builnumberofunraead(int numberofunread) {
    return Container(
        child: Text(
          '$numberofunread',
          style: TextStyle(
            color: Colors.white, // Set the desired text color
          ),
        ),
        alignment: Alignment.center,
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(255, 0, 39, 100),
        ));
  }
}
