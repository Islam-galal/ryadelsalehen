import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ryadelsalehen/Screens/elSabrr.dart';
import 'package:ryadelsalehen/Screens/elTawbaa.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/src/pdf/implementation/pdf_document/pdf_document.dart';
import 'package:syncfusion_flutter_pdf/src/pdf/implementation/pdf_document/outlines/pdf_outline.dart';
import 'package:syncfusion_flutter_pdf/src/pdf/implementation/general/pdf_destination.dart';
import 'package:syncfusion_flutter_pdf/src/pdf/implementation/graphics/pdf_color.dart';
import 'package:syncfusion_flutter_pdf/src/pdf/implementation/pdf_document/outlines/enums.dart';

import '../Widgets/TextButton.dart';
import 'chapters.dart';

class HomePage extends StatefulWidget {
  String id = 'HomePage';
  HomePage();


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? pageNumber = 1;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final GlobalKey<SfPdfViewerState> _pdfviewerStatekey = GlobalKey();
  late PdfViewerController _pdfViewerController;
  late PdfBookmark _pdfBookmark;
  late PdfTextSearchResult _searchResult;

  OverlayEntry? _overlayEntry;
  int _selectedIndex = 0-1;

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
                  Clipboard.setData(
                      ClipboardData(text: details.selectedText.toString().replaceAll("\n", "")));
                  print('Text copied to clipboardssssssssssss: ' +
                      details.selectedText.toString().replaceAll("\n", ""));
                  _pdfViewerController.clearSelection();
                  setState(() {});
                },
                child: Text('Copy',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              TextButton(
                onPressed: () async {

                  String appLink = 'https://www.youtube.com/watch?v=o09miTyQbPk';
                await Share.share('hiiiiiiii \n\n$appLink');
                  _pdfViewerController.clearSelection();
                  setState(() {});
                },
                child: Text('Share',
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          leading: IconButton(onPressed: () async {

            PdfDocument document = PdfDocument(inputBytes: File('images/AllBook.pdf').readAsBytesSync());

            PdfBookmark bookmark = document.bookmarks.add('Page 1');
            bookmark.destination = PdfDestination(document.pages[0], Offset(20, 20));
            // /Sets the bookmark color
            bookmark.color = PdfColor(255, 0, 0);

//Sets the text style
            bookmark.textStyle = [PdfTextStyle.bold];

//Saves the document
            File('output.pdf').writeAsBytes(await document.save());

//Disposes the document
            document.dispose();
          }, icon: Icon(Icons.bookmark_add)),
          title: Center(
            child: Text(
              'دليل الصالحين',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
        ),
        endDrawer: Directionality(
          textDirection: TextDirection.rtl,
          child: Drawer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Container(
                    padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Divider(height: 30,),
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40))),
                          child: TextButton(
                              onPressed: () {
                                _pdfViewerController.jumpToPage(1019);
                                // Then close the drawer
                                Navigator.pop(context);
                              },
                              child: Text(
                                'الفهرس',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )),
                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40))),
                          child: TextButton(
                              onPressed: () {
                                _pdfviewerStatekey.currentState!.openBookmarkView();
                                print(_pdfviewerStatekey.currentState);
                                // _pdfViewerController.jumpToBookmark(_pdfBookmark);
                                // Then close the drawer
                                Navigator.pop(context);
                              },
                              child: Text(
                                'الملاحظات',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )),
                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40))),
                          child: TextButton(
                              onPressed: () {
                                _pdfViewerController.jumpToPage(17);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'نبذة عن الكتاب',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )),
                        ),
                        Divider(),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(

                              color: Colors.blue.shade100,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40))),
                          child: TextButton(
                              onPressed: () {

                              },
                              child: Text(
                                'اجزاء الكتاب :',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.only(left: 10, top: 0, right: 10),
                      itemCount: getChapterNumbers(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40))),
                          child: ListTile(
                            title: Text(
                              '${index + 1} - ' +
                                  '${getChapterName()[index].toString()}',
                              style: TextStyle(
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
        body: SfPdfViewer.asset(
          'images/AllBook.pdf',
         key: _pdfviewerStatekey,
          onDocumentLoaded:(PdfDocumentLoadedDetails details) {
            // _pdfBookmark = details.document.bookmarks[0];
          },
          enableTextSelection: true,
          currentSearchTextHighlightColor: Colors.blue.withOpacity(0.6),
          otherSearchTextHighlightColor: Colors.blue.withOpacity(0.3),
          onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
            if (details.selectedText == null && _overlayEntry != null) {
              _overlayEntry!.remove();
              _overlayEntry = null;
            } else if (details.selectedText != null && _overlayEntry == null) {
              _showContextMenu(context, details);
            }
          },
          controller: _pdfViewerController,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // String customerSearchText = '';
            // openDialog(customerSearchText);

            // int customerPageSelected = openDialog();

            // if(customerPageSelected == null )
            //   return;
            //
            // setState(() {
            //   // this.customerPageselected = customerPageSelected;
            // });

            // _pdfViewerController.jumpToPage(customerPageSelected);

            // search method

            // var TextSearchOption;
            // _searchResult = _pdfViewerController.searchText('الصالحين',
            //     searchOption: TextSearchOption);
            // _searchResult.addListener((){
            //   if (_searchResult.hasResult) {
            //     setState(() {});
            //   }
            // });
            openDialogToPage();

          },
          backgroundColor: Colors.lightBlue,
          child: Icon(Icons.search),
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
        title: Text('اكتب رقم الصفحة'),
        content: TextField(
          onChanged: (data){
             searchText = data;
          },
          // keyboardType: TextInputType.number,
          autofocus: true,
          decoration: InputDecoration(
            hintText: ' رقم الصفحة',

          ),
        ),
        actions: [
          TextButton(
            child: Text('Ok'),
            onPressed: (){

              submit();
            }),
        ],
      ),
    );
    return searchText;
  }

  void openDialogToPage() {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('اكتب رقم الصفحة'),
        content: TextField(
          keyboardType: TextInputType.number,
          onChanged: ( data){
            pageNumber = int.parse(data);

          },
          // keyboardType: TextInputType.number,
          autofocus: true,
          decoration: InputDecoration(
            hintText: ' رقم الصفحة',

          ),
        ),
        actions: [
          TextButton(
              child: Text('Ok'),
              onPressed: (){
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
}
