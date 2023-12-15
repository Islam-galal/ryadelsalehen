// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:ryadelsalehen/Screens/chapters.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// ignore: must_be_immutable
class EndDrawer extends StatelessWidget {
  int selectedIndex = 0 - 1;
  GlobalKey previewContainer;
  final GlobalKey<SfPdfViewerState> pdfViewerKey;
  PdfViewerController pdfViewerController;
  late int currentPage;
  EndDrawer(
      {super.key,
      required this.previewContainer,
      required this.pdfViewerKey,
      required this.pdfViewerController,
      });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Drawer(
          backgroundColor: const Color(0xFF1856F5),
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/za3rafaakter.png'))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: SizedBox(
                      height: 100,
                      child: Image(
                        height: 100,
                        image: AssetImage('images/sidemenupic.png'),
                      )),
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 50, bottom: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Divider(
                        height: 10,
                      ),
                      const Text(
                        ' عن الكتاب : ',
                        style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const Divider(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                            color: Color(0xFF2F80ED),
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: TextButton(
                            onPressed: () {
                              pdfViewerController.jumpToPage(17);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'نبذة عن الكتاب',
                              style: TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ),
                      const Divider(),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                            color: Color(0xFF2F80ED),
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: TextButton(
                            onPressed: () {
                              pdfViewerController.jumpToPage(1019);
                              // Then close the drawer
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'فهرس الكتاب',
                              style: TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ),
                      const Divider(),
                      const Text(
                        ' فهرس الموضوعات : ',
                        style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(left: 50, top: 0, right: 10),
                    itemCount: getChapterNumbers(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Color(0xFF2f80ED),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            '${index + 1}. ${getChapterName()[index]}',
                            style: const TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          selected: selectedIndex == index,
                          textColor: Colors.white,
                          selectedColor: Colors.black,
                          onTap: () {
                            // Update the state of the app
                            onItemTapped(index);
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
              ],
            ),
          )),
    );
  }

  void onItemTapped(int index) {
    selectedIndex = index;
    pdfViewerController.jumpToPage(getPageNumbers(index));
  }
}
