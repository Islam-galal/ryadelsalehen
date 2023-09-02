import 'package:flutter/material.dart';

class FavoritiesWidget extends StatelessWidget {
  FavoritiesWidget({
    required this.favoriteName,
    required this.pageNumber,
    required this.dateAndTime,
  });

  final String favoriteName, pageNumber, dateAndTime;

  @override
  Widget build(BuildContext context) {
    return Card(

      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('اسم المفضله : $favoriteName'),
            Text('رقم الصفحة : $pageNumber'),
            Text('التاريخ : $dateAndTime'),
          ],
        ),
      ),
    );
  }
}
