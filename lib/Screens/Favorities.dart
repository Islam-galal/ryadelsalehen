import 'package:flutter/material.dart';
import 'package:ryadelsalehen/Widgets/FavoritiesWidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ryadelsalehen/Screens/HomePage.dart';

class Favorites extends StatelessWidget {
  String id = 'Favorites';
  int boxlenght = 0;
  final Box data;
  Favorites({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Center(
            child: Text(
          'المفضلات',
          style: TextStyle(fontSize: 30, color: Colors.white),
        )),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(left: 10, top: 0, right: 10),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return   GestureDetector(
                  onTap: (){

                  },
                  child: FavoritiesWidget(

                      favoriteName: data.getAt(index)[1],
                      pageNumber: data.getAt(index)[2],
                      dateAndTime: data.getAt(index)[3]

                  ),
                );

              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
        ],
      ),
    );
  }

  void getBookMarkNumber() async {
    await Hive.initFlutter();
    var box = await Hive.openBox("Bookmark");

    boxlenght = box.length;
  }
}
