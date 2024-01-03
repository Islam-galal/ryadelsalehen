import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ryadelsalehen/helper/widgets_helper.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CustomDrawer extends StatelessWidget {
  int selectedIndex = 0 - 1;
  int numberOfBookMarks;
  GlobalKey previewContainer;

  PdfViewerController pdfViewerController;
  int currentPage;
  String bookmarksKey;
  late TextEditingController textEditingController;
  late Box box ;

  CustomDrawer({
    super.key,
    required this.previewContainer,
    required this.textEditingController,
    required this.pdfViewerController,
    required this.numberOfBookMarks,
    required this.bookmarksKey,
    required this.currentPage,
    required this.box,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1856F5),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/za3rafaakter.png'),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Divider(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                        color: Color(0xFF2F80ED),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: TextButton(
                        onPressed: () {
                          // Then close the drawer
                          Navigator.pop(context);

                          // openDialogToAddBookmark();
                          Helper().openDialogToAddBookmark(
                            snakBarDuration: 4,
                            box: box,
                            bookmarkskey: bookmarksKey,
                            buildContext: context,
                            textEditingController: textEditingController,
                            numberOfBookMarks: numberOfBookMarks,
                            currentPage: currentPage,
                          );
                        },
                        child: const Text(
                          '+ اضف الصفحه الحاليه الي المفضلات',
                          style: TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ),
                  const Divider(),
                  const Text(
                    'قائمة المفضلات : ',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Divider(
                    height: 10,
                  ),
                ],
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 10, top: 0, right: 10),
                  itemCount: box.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          color: Color(0xFF2F80ED),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: ListTile(
                        onLongPress: () {
                          Helper().openDialogToDeleteBookmark(
                            buildContext: context,
                            box: box,
                            index: index,
                            snakBarDuration: 4,
                            bookmarksKey: bookmarksKey,
                            textEditingController: textEditingController,
                          );
                        },
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${index + 1} - '
                              'اسم المفضلة : ${box.getAt(index)[1]}',
                              style: const TextStyle(
                                  fontFamily: 'Tajawal',
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'رقم الصفحة : ${box.getAt(index)[2]}',
                              style: const TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'التاريخ :${box.getAt(index)[3]}',
                              style: const TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        selected: selectedIndex == index,
                        onTap: () {
                          // Update the state of the app
                          _onItemFavoriteTapped(int.parse(box.getAt(index)[2]));

                          // Then close the drawer
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemFavoriteTapped(int index) {
    selectedIndex = index;
    pdfViewerController.jumpToPage(index);
  }
}
