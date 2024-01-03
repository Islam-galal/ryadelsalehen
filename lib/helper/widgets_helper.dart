// ignore: depend_on_referenced_packages
// ignore_for_file: avoid_print

// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  late int bookMarks;
  late final int pageNumber;

  void deleteWidget(
      {required BuildContext context,
      required TextEditingController textController}) {
    Navigator.of(context).pop(textController.text);
  }

  int getNumberOfBookMarks() {
    return bookMarks;
  }

  void openDialogToAddBookmark({
    required snakBarDuration,
    required bookmarkskey,
    required buildContext,
    required textEditingController,
    required numberOfBookMarks,
    required currentPage,
    required box,
  }) {
    String bookMarkCaption = null.toString();
    showDialog(
      context: buildContext,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('هل تريد الاضافة الي المفضلة.؟'),
          content: TextFormField(
            validator: (data) {
              if (data!.isEmpty) {
                return 'field is required';
              }
              return null;
            },
            keyboardType: TextInputType.text,
            onChanged: (data) {
              bookMarkCaption = data;
            },
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'اضف عنوان',
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    child: const Text('نعم'),
                    onPressed: () async {
                      if (bookMarkCaption != null.toString()) {
                        saveIntegerToLocalStorage(
                            key: bookmarkskey, value: numberOfBookMarks);
                        addBookMark(
                          bookMarkCaption: bookMarkCaption,
                          box: box,
                          currentPage: currentPage,
                          snakBarDuration: 4,
                          context: context,
                          bookmarkskey: bookmarkskey,
                        );
                        bookMarks = numberOfBookMarks + 1;
                        Helper().deleteWidget(
                            context: context,
                            textController: textEditingController);
                      } else if (bookMarkCaption == null.toString()) {
                        var snackBar = SnackBar(
                            duration: Duration(seconds: snakBarDuration),
                            content: const Text(" برجاء ادخال اسم المفضلة."));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }),
                TextButton(
                    child: const Text('لا'),
                    onPressed: () {
                      Helper().deleteWidget(
                          context: context,
                          textController: textEditingController);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }

  void openDialogToDeleteBookmark({
    required buildContext,
    required box,
    required index,
    required snakBarDuration,
    required bookmarksKey,
    required textEditingController,
  }) {
    showDialog(
      context: buildContext,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('هل تريد حذف المفضلة ؟'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    child: const Text('نعم'),
                    onPressed: () async {
                      box.deleteAt(index);
                      deleteWidget(
                        context: buildContext,
                        textController: textEditingController,
                      );
                      Navigator.pop(context);
                      var snackBar = SnackBar(
                          duration: Duration(seconds: snakBarDuration),
                          content: const Text("تم الحذف بنجاح"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }),
                TextButton(
                    child: const Text('لا'),
                    onPressed: () {
                      deleteWidget(
                        context: buildContext,
                        textController: textEditingController,
                      );
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openDialogToPage({
    required snakBarDuration,
    required buildContext,
    required textEditingControll,
    required pdfViewerController,
  }) {
    late int pageNumberNavigate;

    showDialog(
      context: buildContext,
      builder: (context) => AlertDialog(
        title: const Text('اكتب رقم الصفحه بالغه الانجليزيه'),
        content: TextField(
          keyboardType: TextInputType.number,
          onChanged: (data) {
            pageNumberNavigate = int.parse(data);
          },
          autofocus: true,
          decoration: const InputDecoration(
            hintText: ' رقم الصفحة',
          ),
        ),
        actions: [
          TextButton(
              child: const Text('Ok'),
              onPressed: () {
                if (pageNumberNavigate <= 1065) {
                  pdfViewerController.jumpToPage(pageNumberNavigate);
                  deleteWidget(
                      context: buildContext,
                      textController: textEditingControll);
                } else {
                  var snackBar = SnackBar(
                      duration: Duration(seconds: snakBarDuration),
                      content: const Text(
                          "لا توجد صفحه بهذا الرقم ادخل من ١ الي ١٠٦٥"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }),
        ],
      ),
    );
  }

  Future<void> saveIntegerToLocalStorage({required key, required value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
    bookMarks = prefs.getInt(key)!;
  }

  addBookMark({
    required bookMarkCaption,
    required box,
    required currentPage,
    required snakBarDuration,
    required context,
    required bookmarkskey,
  }) async {
    List<String> newBookMark = [
      (box.length + 1).toString(),
      bookMarkCaption,
      currentPage.toString(),
      '${DateTime.now().year} - ${DateTime.now().month} - ${DateTime.now().day}'
          .toString(),
    ];
    box.add(newBookMark);
    var snackBar = SnackBar(
        duration: Duration(seconds: snakBarDuration),
        content: const Text(" تم الاضافه بنجاح"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print('Info added to box!');
    print(box.get(bookmarkskey).toString());
  }
}
