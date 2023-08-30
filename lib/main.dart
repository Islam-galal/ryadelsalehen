import 'package:flutter/material.dart';
import 'package:ryadelsalehen/Screens/HomePage.dart';
import 'package:ryadelsalehen/Screens/elSabrr.dart';
import 'package:ryadelsalehen/Screens/elTawbaa.dart';
import 'package:ryadelsalehen/Screens/HomePage.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'Widgets/TextButton.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // HomePage().id : (context) => HomePage(),
        // ElTawbaa().id : (context) => ElTawbaa(),
        // ElSabr().id : (context) => ElSabr(),
        HomePage().id : (context)=> HomePage(),


      },
      debugShowCheckedModeBanner: false,
      initialRoute: "HomePage",
    );
  }
}


