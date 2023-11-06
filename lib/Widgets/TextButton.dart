import 'package:flutter/material.dart';

class ButtonField extends StatelessWidget {
  ButtonField({super.key, 
    required this.text,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
       onPressed: (){},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(100),
        ),
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
