// ignore_for_file: must_be_immutable, depend_on_referenced_packages, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomAppBarTitle extends StatelessWidget {
  CustomAppBarTitle({required this.text, required this.text2});
  String text;
  String text2;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        alignment: Alignment.bottomCenter,
        child: Center(
            widthFactor: 120,
            child: Text(
              '$text' '\n' '$text2',
              style: const TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 20,
                decoration: TextDecoration.none,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )
            ));
  }
}
