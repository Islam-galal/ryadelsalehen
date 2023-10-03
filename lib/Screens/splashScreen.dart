// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:ryadelsalehen/Screens/HomePage.dart';
//
// class SplashScreen extends StatefulWidget {
//   String id = 'SplashScreen';
//
//    SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//   @override
//   void initState() {
//
//     super.initState();
//     Timer(Duration(seconds: 3),
//             ()=>Navigator.pushReplacement(context,
//             MaterialPageRoute(builder:
//                 (context) =>
//                 HomePage(box: box)
//             )
//         )
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Image.asset('images/splash.jpeg'),
//     );
//   }
// }
