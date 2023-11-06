// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';

class FavoritiesWidget extends StatelessWidget {
  const FavoritiesWidget({super.key, 
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
        padding: const EdgeInsets.all(8.0),
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
