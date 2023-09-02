import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ryadelsalehen/Screens/Favorities.dart';
import 'package:ryadelsalehen/Screens/HomePage.dart';


void main() async{
  await Hive.initFlutter();

  var currentPageBox = await Hive.openBox('lastPage');

  var bookMarkedBox = await Hive.openBox('bookMarked');

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

        HomePage().id : (context)=> HomePage(),
        // Favorites().id : (context)=> Favorites(),


      },
      debugShowCheckedModeBanner: false,
      initialRoute: "HomePage",
    );
  }
}


