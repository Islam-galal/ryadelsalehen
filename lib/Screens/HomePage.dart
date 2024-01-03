// ignore: depend_on_referenced_packages
// ignore_for_file: file_names, depend_on_referenced_packages, must_be_immutable, duplicate_ignore, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ryadelsalehen/Screens/drawer.dart';
import 'package:ryadelsalehen/Screens/end_viewer.dart';
import 'package:ryadelsalehen/Widgets/app_bar_leading.dart';
import 'package:ryadelsalehen/Widgets/app_bar_title.dart';
import 'package:ryadelsalehen/Widgets/scroll_button.dart';
import 'package:ryadelsalehen/Widgets/sf_pdf_viewer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HomePage extends StatefulWidget {
  String id = 'HomePage';
  Box box;

  HomePage({super.key, required this.box});

  @override
  State<HomePage> createState() => _HomePageState(homeBox: box);
}

class _HomePageState extends State<HomePage> {
  late Box homeBox;

  int snakBarDuration = 4;
  _HomePageState({required this.homeBox});

  late String favoriteName;

  bool favoriteVisability = false;

  final String _bookmarkskey = 'Bookmark';
  int pageNumber = 1;
  int lastPageViewed = 1;
  int originalSize = 800;
  final int _currentPage = 1;
  int _numberOfBookmarks = 0;
  final double _zoom = 1;
  final String _bookMarkCaption = null.toString();
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late PdfViewerController _pdfViewerController;
  GlobalKey previewContainer = GlobalKey();

  late TextEditingController textController;

  double boxsize = 1.0;

  double boxsizeheader = 35;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    textController = TextEditingController();

    super.initState();
  }

  // -----------------------------SharedPreference-------------------------------
  Future<void> saveIntegerToLocalStorage(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
    _numberOfBookmarks = prefs.getInt(key)!;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          toolbarHeight: 75,
          elevation: 0,
          backgroundColor: const Color(0xFF1856F5),
          leadingWidth: 120,
          leading: CustomAppBarLeading(
            previewContainer: previewContainer,
            bookMarkCaption: _bookMarkCaption,
            bookmarkskey: _bookmarkskey,
            textController: textController,
            pdfViewerController: _pdfViewerController,
            originalSize: originalSize,
          ),
          title: CustomAppBarTitle(
            text: 'دليل المعاصرين',
            text2: 'شرح رياض الصالحين',
          ),
        ),
        drawer: CustomDrawer(
            previewContainer: previewContainer,
            numberOfBookMarks: _numberOfBookmarks,
            textEditingController: textController,
            pdfViewerController: _pdfViewerController,
            bookmarksKey: _bookmarkskey,
            currentPage: _currentPage,
            box: homeBox),
        endDrawer: EndDrawer(
            previewContainer: previewContainer,
            pdfViewerKey: _pdfViewerKey,
            pdfViewerController: _pdfViewerController),
        body: Stack(children: [
          SyncfusionPdfViewerWidget(
              pdfPath: 'images/AllBook.pdf',
              zoom: _zoom,
              padding: 10,
              previewContainer: previewContainer,
              pdfViewerKey: _pdfViewerKey,
              pdfViewerController: _pdfViewerController,
              currentPage: _currentPage),
          ScrollButton(
              direction: 'LEFT', onPressed: _pdfViewerController, padding: 20),
          ScrollButton(
              direction: 'RIGHT', onPressed: _pdfViewerController, padding: 20),
        ]),
      ),
    );
  }
}
