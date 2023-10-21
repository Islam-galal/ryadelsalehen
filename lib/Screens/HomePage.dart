import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/src/pdf/implementation/pdf_document/outlines/pdf_outline.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chapters.dart';

class HomePage extends StatefulWidget {
  String id = 'HomePage';
  Box box;

  HomePage({required this.box});

  @override
  State<HomePage> createState() => _HomePageState(ziad: box);
}

class _HomePageState extends State<HomePage> {
  late Box ziad;

  int snakBarDuration = 4;
  _HomePageState({required this.ziad});

  late String favoriteName;

  bool favoriteVisability = false;

  int _boxLenght = 0;

  final String _bookmarkskey = 'Bookmark';
  late var _getData;
  int pageNumber = 1;
  int lastPageViewed = 1;
  int originalSize = 800;
  late int _currentPage = 1;
  int _numberOfBookmarks = 0;
  double _zoom = 1;

  String _bookMarkCaption = null.toString();
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final GlobalKey<SfPdfViewerState> _pdfviewerStatekey = GlobalKey();
  late PdfViewerController _pdfViewerController;
  late PdfBookmark _pdfBookmark;
  late PdfTextSearchResult _searchResult;
  GlobalKey previewContainer = new GlobalKey();

  OverlayEntry? _overlayEntry;
  int _selectedIndex = 0 - 1;

  late TextEditingController textController;

  double boxsize = 1.0;

  double boxsizeheader = 35;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
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
    final prefs1 = await prefs.getInt(key);
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
    final OverlayState _overlayState = Overlay.of(context)!;
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
                  print('Text copied to clipboardssssssssssss: ' +
                      details.selectedText.toString().replaceAll("\n", ""));
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
                  String appLink =
                      'https://www.youtube.com/@aljalsah6417';
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
    _overlayState.insert(_overlayEntry!);
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
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.lightBlue,
          leadingWidth: 100,
          leading: Row(
            children: [
              Builder(
                builder: (context) {
                  return IconButton(
                    icon: Icon(Icons.bookmark),
                    onPressed: () async {
                      _bookMarkCaption =null.toString();
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
              IconButton(
                  onPressed: () {
                    ShareFilesAndScreenshotWidgets().shareScreenshot(
                      previewContainer,
                      originalSize,
                      "Title",
                      "Name.png",
                      "image/png",
                    );
                  },
                  icon: Icon(Icons.share)),
            ],
          ),
          title: Container(
              alignment: Alignment.center,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'دليل المعاصرين \n',
                          style: TextStyle(fontSize: 20 , decoration: TextDecoration.none , color: Colors.white , fontWeight: FontWeight.bold , ) ),
                      TextSpan(
                          text: 'شرح رياض الصالحين',
                          style: TextStyle(fontSize: 17 , decoration: TextDecoration.none , color: Colors.white))
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
                              '${index + 1} - ' +
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
                          '${index + 1} - ' +
                              '${getChapterName()[index].toString()}',
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
              padding: EdgeInsets.only(bottom: 100),
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
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () {
                  _pdfViewerController.previousPage();
                },
                icon: Icon(
                  Icons.arrow_circle_left_sharp,
                  size: 40,
                  color: Colors.lightBlue,
                )),
          ),
          Container(
            padding: EdgeInsets.only(right: 5),
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  _pdfViewerController.nextPage();
                },
                icon: Icon(
                  Icons.arrow_circle_right_sharp,
                  size: 40,
                  color: Colors.lightBlue,
                )),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // getCurrentPageNumber();
            openDialogToPage();
            await Hive.initFlutter();
            var box = await Hive.openBox(_bookmarkskey);
            for (int i = 0; i < box.length; i++) {
              print(box.getAt(i));
            }
          },
          backgroundColor: Colors.lightBlue,
          child: const Icon(Icons.search),
        ),
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
          title: Text('هل تريد الاضافة الي المفضلة.؟'),
          content: TextFormField(
            validator: (data) {
              if (data!.isEmpty) {
                return 'field is required';
              }
            },
            keyboardType: TextInputType.text,
            onChanged: (data) {
              _bookMarkCaption = data;
            },
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'اضف عنوان',
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    child: Text('نعم'),
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
                            content: Text(" برجاء ادخال اسم المفضلة."));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }),
                TextButton(
                    child: Text('لا'),
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
          title: Text('هل تريد حذف المفضلة ؟'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    child: Text('نعم'),
                    onPressed: () async {
                      await Hive.initFlutter();
                      var box = await Hive.openBox(_bookmarkskey);

                      box.deleteAt(index);
                      submit();
                      Navigator.pop(context);
                      var snackBar = SnackBar(
                          duration: Duration(seconds: snakBarDuration),
                          content: Text("تم الحذف بنجاح"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }),
                TextButton(
                    child: Text('لا'),
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
        title: const Text('اكتب رقم الصفحة'),
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
                _pdfViewerController.jumpToPage(pageNumber!);
                submit();
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
          content: Text(" تم الاضافه بنجاح"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      print('Info added to box!');
      print(box.get(_bookmarkskey).toString());
      _boxLenght = box.length;
    }
  }

class MySplashScreen extends StatefulWidget {
  final Box box;
  MySplashScreen({required this.box});
  @override
  _MyHomePageState createState() => _MyHomePageState(box: box);
}

class _MyHomePageState extends State<MySplashScreen> {
  Box box;
  _MyHomePageState({required this.box});

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage(box: box))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Column(
        children: [
          Container(
            color: Color.fromRGBO(215, 232, 237, 1.0),
            height: MediaQuery.of(context).size.height / 4,
          ),
          Container(
            child: Image.asset('images/splash.jpeg'),
          ),
          Expanded(
            child: Container(
              color: Color.fromRGBO(27, 30, 64, 1.0),
              height: 145,
            ),
          ),
        ],
      ),
    );
  }
}
