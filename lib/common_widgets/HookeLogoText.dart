import 'package:flutter/material.dart';

class HookeLogoText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text(
      "hooke",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Tondo', 
          fontSize: 100, 
          color: Colors.red),
    );
  }
}