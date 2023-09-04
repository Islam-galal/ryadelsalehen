import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ryadelsalehen/Screens/Favorities.dart';
import 'package:ryadelsalehen/Screens/HomePage.dart';


void main() async{
  await Hive.initFlutter();
  var bookMarkedBox = await Hive.openBox('bookMarked');
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp(box: bookMarkedBox,));
}

class MyApp extends StatelessWidget {
  Box box;
   MyApp({required this.box});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {

        HomePage(box: box,).id : (context)=> HomePage(box: box,),
        // Favorites().id : (context)=> Favorites(),


      },
      debugShowCheckedModeBanner: false,
      initialRoute: "HomePage",
    );
  }
}


