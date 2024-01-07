// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'Screens/Splash.dart';


Future<void> main() async {
  Firebase.initializeApp();
  await Hive.initFlutter();
  var bookMarkedBox = await Hive.openBox('bookMarked');
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

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
