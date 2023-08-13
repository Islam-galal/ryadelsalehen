import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ryadelsalehen/Screens/elSabrr.dart';
import 'package:ryadelsalehen/Screens/elTawbaa.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../Widgets/TextButton.dart';

class ElAkhlass extends StatefulWidget {
  String id = 'ElAkhlass';
  ElAkhlass();

  @override
  State<ElAkhlass> createState() => _ElAkhlassState();
}

class _ElAkhlassState extends State<ElAkhlass> {
  late PdfViewerController _pdfViewerController;
  late PdfTextSearchResult _searchResult;
  OverlayEntry? _overlayEntry;

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
        child: TextButton(
          onPressed: () {
            Clipboard.setData(
                ClipboardData(text: details.selectedText.toString()));
            print('Text copied to clipboardssssssssssss: ' +
                details.selectedText.toString());
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
      ),
    );
    _overlayState.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
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
        endDrawer: Drawer(
          child: ListView(
            children: [
              Container(
                height: 75,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.green),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.room_preferences),
                              Text('المرجعيات'),
                            ],
                          ),
                          SizedBox(
                            width: boxsizeheader,
                          ),
                          Column(
                            children: [
                              Icon(Icons.note_alt_sharp),
                              Text('الملاحظات'),
                            ],
                          ),
                          SizedBox(
                            width: boxsizeheader,
                          ),
                          Column(
                            children: [Icon(Icons.ac_unit), Text('الاجزاء')],
                          ),
                          SizedBox(
                            width: boxsizeheader,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ElAkhlass().id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      width: double.infinity,
                      height: 60,
                      child: Center(
                        child: Text(
                          'الإخـــــــــــــــلاصُ',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: boxsize,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {});
                      Navigator.pushNamed(context, ElAkhlass().id);
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      width: double.infinity,
                      height: 60,
                      child: Center(
                        child: Text(
                          'التوبة',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: boxsize,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ElSabr().id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      width: double.infinity,
                      height: 60,
                      child: Center(
                        child: Text(
                          'الصبرُ',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: boxsize,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ElSabr().id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      width: double.infinity,
                      height: 60,
                      child: Center(
                        child: Text(
                          'Test',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // FutureBuilder<List<Map<String, dynamic>>>(
              //   builder: (context, snapshot) {
              //     if (!snapshot.hasData) {
              //       return const Center(child: CircularProgressIndicator());
              //     }
              //     final data = snapshot.data!;
              //     return ListView.builder(
              //       itemCount: data.length,
              //       itemBuilder: ((context, index) {
              //         final sections_data = data[index];
              //         return Expanded(child: ButtonField(text: sections_data['sections']));
              //       }),
              //     );
              //   },
              // ),
            ],
          ),
        ),
        body: SfPdfViewer.asset(
          'images/دليل المعاصرين_ الطبعة الرابعة_ تنسيق نهائي.pdf',
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
            openDialog();

            int customerPageSelected = openDialog();

            if(customerPageSelected == null )
              return;

            setState(() {
              // this.customerPageselected = customerPageSelected;
            });

            _pdfViewerController.jumpToPage(customerPageSelected);

            // search method

            // var TextSearchOption;
            // _searchResult = _pdfViewerController.searchText('hi',
            //     searchOption: TextSearchOption);
            // _searchResult.addListener((){
            //   if (_searchResult.hasResult) {
            //     setState(() {});
            //   }
            // });
          },
          backgroundColor: Colors.green,
          child: Icon(Icons.search),
        ),
      ),
    );
  }

  int getCustomerPageNumber(int pageNumber) {
    int customerPgaeNumber = pageNumber;

    return customerPgaeNumber;
  }

  int openDialog() {
    var pageNumber;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter Page Number'),
        content: TextField(
          onChanged: (data){
            pageNumber = data;
          },
          keyboardType: TextInputType.number,

          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter Here your Page Number',

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
    return pageNumber!;
  }

  void submit() {
    Navigator.of(context).pop(textController.text);
  }
}
