import 'package:flutter/material.dart';
import 'package:ryadelsalehen/Screens/elSabrr.dart';
import 'package:ryadelsalehen/Screens/elTawbaa.dart';
import 'package:ryadelsalehen/Screens/elakhlass.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'Widgets/TextButton.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        ElAkhlass().id : (context) => ElAkhlass(),
        ElTawbaa().id : (context) => ElTawbaa(),
        ElSabr().id : (context) => ElSabr(),


      },
      debugShowCheckedModeBanner: false,
      initialRoute: "ElAkhlass",
    );
  }
}


