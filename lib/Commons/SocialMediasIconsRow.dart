import 'package:flutter/material.dart';

class SocialMediaIconsRow extends StatelessWidget {
  const SocialMediaIconsRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Transform.scale(
          scale: 1,
          child: Image.asset(
            'assets/images/fb.png', // Replace with the path to your image
            width: 50,
            height: 50,
          ),
        ),
        Transform.scale(
          scale: 1,
          child: Image.asset(
            'assets/images/apple.png', // Replace with the path to your image
            width: 50,
            height: 50,
          ),
        ),
        Transform.scale(
          scale: 1,
          child: Image.asset(
            'assets/images/google.png', // Replace with the path to your image
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }
}
