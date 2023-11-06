// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'Screens/Splash.dart';


void main() async {
  await Hive.initFlutter();
  var bookMarkedBox = await Hive.openBox('bookMarked');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    box: bookMarkedBox,
  ));
}

// from my laptop

class MyApp extends StatelessWidget {
  final Box box;
  const MyApp({super.key, required this.box});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MySplashScreen(box: box),
      debugShowCheckedModeBanner: false,
    );
  }
}
