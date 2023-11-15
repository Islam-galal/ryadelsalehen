import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdf/src/pdf/implementation/pdf_document/outlines/pdf_outline.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'chapters.dart';

class HomePage extends StatefulWidget {
  String id = 'HomePage';
  Box box;

  HomePage({super.key, required this.box});

  @override
  State<HomePage> createState() => _HomePageState(ziad: box);
}

class _HomePageState extends State<HomePage> {
  late Box ziad;

  int snakBarDuration = 4;
  _HomePageState({required this.ziad});

  late String favoriteName;

  bool favoriteVisability = false;

  final String _bookmarkskey = 'Bookmark';
  int pageNumber = 1;
  int lastPageViewed = 1;
  int originalSize = 800;
  late int _currentPage = 1;
  int _numberOfBookmarks = 0;
  final double _zoom = 1;

  String _bookMarkCaption = null.toString();
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late PdfViewerController _pdfViewerController;
  GlobalKey previewContainer = GlobalKey();

  OverlayEntry? _overlayEntry;
  int _selectedIndex = 0 - 1;

  late TextEditingController textController;

  double boxsize = 1.0;

  double boxsizeheader = 35;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    textController = TextEditingController();

    super.initState();
  }

  //-----------------------------SharedPreference-------------------------------
  Future<void> saveIntegerToLocalStorage(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
    _numberOfBookmarks = prefs.getInt(key)!;
  }

  void getStringFromLocalStorage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final prefs1 = prefs.getInt(key);
    setState(() {
      if (_currentPage != 0) {
        _currentPage = prefs1!;
      }
    });
    // return prefs1 ?? 1;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void _showContextMenu(
      BuildContext context, PdfTextSelectionChangedDetails details) {
    final OverlayState overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: details.globalSelectedRegion!.center.dy - 75,
        left: details.globalSelectedRegion!.bottomLeft.dx,
        child: Container(
          color: Colors.grey.shade100,
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                      text: details.selectedText
                          .toString()
                          .replaceAll("\n", "")));
                  print(
                      'Text copied to clipboardssssssssssss: ${details.selectedText.toString().replaceAll("\n", "")}');
                  _pdfViewerController.clearSelection();
                  setState(() {});
                },
                child: const Text('Copy',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              TextButton(
                onPressed: () async {
                  String appLink = 'https://www.youtube.com/@aljalsah6417';
                  await Share.share('hiiiiiiii \n\n$appLink');
                  _pdfViewerController.clearSelection();
                  setState(() {});
                },
                child: const Text('Share',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
    overlayState.insert(_overlayEntry!);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pdfViewerController.jumpToPage(getPageNumbers(index));
    });
  }

  void _onItemFavoriteTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pdfViewerController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          toolbarHeight: 75,
          elevation: 0,
          backgroundColor: Colors.lightBlue,
          leadingWidth: 120,
          leading: Row(
            children: [
              Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () async {
                      _bookMarkCaption = null.toString();
                      await Hive.initFlutter();
                      var box = await Hive.openBox(_bookmarkskey);
                      setState(() {
                        ziad = box;
                      });
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              Expanded(
                child: IconButton(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    onPressed: () {
                      ShareFilesAndScreenshotWidgets().shareScreenshot(
                        previewContainer,
                        originalSize,
                        "Title",
                        "Name.png",
                        "image/png",
                      );
                    },
                    icon: const Icon(Icons.share_sharp)),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                // new search buttom
                child: Container(
                  color: Colors.lightBlue,
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 400,
                              child: Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                        "hereee add data you need ")),
                              ),
                            );
                          });
                    },
                    child: const Icon(
                      Icons.search,
                    ),
                  ),
                ),

                // child: IconButton(
                //     padding: const EdgeInsets.symmetric(vertical: 10),
                //     onPressed: () {
                //       openDialogToPage();
                //     },
                //     icon: const Icon(Icons.search)),
              ),
            ],
          ),
          title: Container(
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Center(
                widthFactor: 120,
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'دليل المعاصرين \n',
                          style: TextStyle(
                            fontSize: 20,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                      TextSpan(
                          text: 'شرح رياض الصالحين',
                          style: TextStyle(
                              fontSize: 17,
                              decoration: TextDecoration.none,
                              color: Colors.white))
                    ],
                  ),
                ),
              )),
        ),
        drawer: Drawer(
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
                    decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: TextButton(
                        onPressed: () {
                          // Then close the drawer
                          Navigator.pop(context);

                          openDialogToBookmark();
                        },
                        child: const Text(
                          'اضف الي المفضلات',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                  ),
                  const Divider(),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'قائمة المفضلات : ',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 10, top: 0, right: 10),
                  itemCount: ziad.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40))),
                      child: ListTile(
                        onLongPress: () {
                          openDialogToDeleteBookmark(index);
                        },
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${index + 1} - '
                              'اسم المفضلة : ${ziad.getAt(index)[1]}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'رقم الصفحة : ${ziad.getAt(index)[2]}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'التاريخ :${ziad.getAt(index)[3]}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        selected: _selectedIndex == index,
                        onTap: () {
                          // Update the state of the app
                          _onItemFavoriteTapped(
                              int.parse(ziad.getAt(index)[2]));

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
        )),
        endDrawer: Directionality(
          textDirection: TextDirection.rtl,
          child: Drawer(
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
                      decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: TextButton(
                          onPressed: () {
                            _pdfViewerController.jumpToPage(17);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'نبذة عن الكتاب',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                    ),
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: TextButton(
                          onPressed: () {
                            _pdfViewerController.jumpToPage(1019);
                            // Then close the drawer
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'فهرس الموضوعات',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 10, top: 0, right: 10),
                  itemCount: getChapterNumbers(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40))),
                      child: ListTile(
                        title: Text(
                          '${index + 1} - ${getChapterName()[index]}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        selected: _selectedIndex == index,
                        onTap: () {
                          // Update the state of the app
                          _onItemTapped(index);
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
          )),
        ),
        body: Stack(children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(bottom: 10),
              child: SfPdfViewerTheme(
                data: SfPdfViewerThemeData(
                  backgroundColor: Colors.white,
                ),
                child: RepaintBoundary(
                  key: previewContainer,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: SfPdfViewer.asset(
                        'images/AllBook.pdf',
                        key: _pdfViewerKey,
                        canShowScrollHead: false,
                        controller: _pdfViewerController,
                        enableTextSelection: false,
                        scrollDirection: PdfScrollDirection.horizontal,
                        onPageChanged: (PdfPageChangedDetails details) {
                          _currentPage = _pdfViewerController.pageNumber;
                          saveIntegerToLocalStorage(
                              'currentPage', _currentPage);
                          setState(() {});
                        },
                        currentSearchTextHighlightColor:
                            Colors.blue.withOpacity(0.6),
                        otherSearchTextHighlightColor:
                            Colors.blue.withOpacity(0.3),
                        initialZoomLevel: _zoom,
                        pageLayoutMode: PdfPageLayoutMode.single,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _pdfViewerController.previousPage();
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(30)),
                  // color: Colors.red,
                  width: 110,
                  height: 50,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'السابق',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _pdfViewerController.nextPage();
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(30)),
                  // color: Colors.red,
                  width: 110,
                  height: 50,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'التالي',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Container(
          //   color: Colors.red,
          //   height: 70,
          // ),
          // Directionality(
          //   textDirection: TextDirection.rtl,
          //   child: Container(
          //     margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
          //     height: 50,
          //     child: TextField(
          //       keyboardType: TextInputType.number,
          //       cursorColor: Colors.grey,
          //       decoration: InputDecoration(
          //         contentPadding: EdgeInsets.all(5),
          //         fillColor: Colors.white,
          //         filled: true,
          //         hintTextDirection: TextDirection.rtl,
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(30),
          //           borderSide: BorderSide.none,
          //         ),
          //         prefixIcon: Container(
          //           child: Icon(
          //             Icons.search_outlined,
          //             color: Colors.grey,
          //           ),
          //         ),
          //         hintText: '  ابحث برقم الصفحة ..',
          //         hintStyle: TextStyle(
          //           color: Colors.grey,
          //         ),
          //       ),
          //       onChanged: (value) {
          //         _pdfViewerController.jumpToPage(int.parse(value));
          //       },
          //     ),
          //   ),
          // ),
        ]),
      ),
    );
  }

  int getCustomerPageNumber(int pageNumber) {
    int customerPgaeNumber = pageNumber;

    return customerPgaeNumber;
  }

  String openDialogToSearch(String searchText) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('اكتب رقم الصفحة'),
        content: TextField(
          onChanged: (data) {
            searchText = data;
          },
          // keyboardType: TextInputType.number,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: ' رقم الصفحة',
          ),
        ),
        actions: [
          TextButton(
              child: const Text('Ok'),
              onPressed: () {
                submit();
              }),
        ],
      ),
    );
    return searchText;
  }

  void openDialogToBookmark() {
    showDialog(
      context: context,
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
              _bookMarkCaption = data;
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
                      if (_bookMarkCaption != null.toString()) {
                        await Hive.initFlutter();
                        var box = await Hive.openBox(_bookmarkskey);
                        saveIntegerToLocalStorage(
                            _bookmarkskey, _numberOfBookmarks);
                        _addBookMark(_bookMarkCaption, box);
                        _numberOfBookmarks = _numberOfBookmarks + 1;
                        submit();
                      } else if (_bookMarkCaption == null.toString()) {
                        var snackBar = SnackBar(
                            duration: Duration(seconds: snakBarDuration),
                            content: const Text(" برجاء ادخال اسم المفضلة."));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }),
                TextButton(
                    child: const Text('لا'),
                    onPressed: () {
                      submit();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }

  void openDialogToDeleteBookmark(int index) {
    showDialog(
      context: context,
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
                      await Hive.initFlutter();
                      var box = await Hive.openBox(_bookmarkskey);

                      box.deleteAt(index);
                      submit();
                      Navigator.pop(context);
                      var snackBar = SnackBar(
                          duration: Duration(seconds: snakBarDuration),
                          content: const Text("تم الحذف بنجاح"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }),
                TextButton(
                    child: const Text('لا'),
                    onPressed: () {
                      submit();
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openDialogToPage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('اكتب رقم الصفحه بالغه الانجليزيه'),
        content: TextField(
          keyboardType: TextInputType.number,
          onChanged: (data) {
            pageNumber = int.parse(data);
          },
          // keyboardType: TextInputType.number,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: ' رقم الصفحة',
          ),
        ),
        actions: [
          TextButton(
              child: const Text('Ok'),
              onPressed: () {
                if (pageNumber <= 1065) {
                  _pdfViewerController.jumpToPage(pageNumber);
                  submit();
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

  void submit() {
    Navigator.of(context).pop(textController.text);
  }

  _addBookMark(String name, Box box) async {
    List<String> newBookMark = [
      (box.length + 1).toString(),
      name,
      _currentPage.toString(),
      '${DateTime.now().year} - ${DateTime.now().month} - ${DateTime.now().day}'
          .toString(),
    ];
    box.add(newBookMark);
    var snackBar = SnackBar(
        duration: Duration(seconds: snakBarDuration),
        content: const Text(" تم الاضافه بنجاح"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    print('Info added to box!');
    print(box.get(_bookmarkskey).toString());
  }
}
