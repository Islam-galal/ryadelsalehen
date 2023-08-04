import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../Widgets/TextButton.dart';
import 'elSabrr.dart';
import 'elakhlass.dart';

class ElTawbaa extends StatefulWidget {
  String id = 'ElTawbaa';
   ElTawbaa({super.key});

  @override
  State<ElTawbaa> createState() => _ElTawbaaState();
}

class _ElTawbaaState extends State<ElTawbaa> {

  late PdfViewerController _pdfViewerController;
  OverlayEntry? _overlayEntry;

  double boxsize = 1.0;

  double boxsizeheader = 35;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
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
            Clipboard.setData(ClipboardData(text: details.selectedText.toString()));
            print(
                'Text copied to clipboardssssssssssss: ' + details.selectedText.toString());
            _pdfViewerController.clearSelection();
            setState(() {

            });
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
                      Navigator.pushNamed(context, ElTawbaa().id);
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
                  // ButtonField(
                  //
                  //   text: 'الصدقُ',
                  // ),
                  // SizedBox(
                  //   height: boxsize,
                  // ),
                  // ButtonField(
                  //
                  //   text: 'المُرَاقَبَةُ',
                  // ),
                  // SizedBox(
                  //   height: boxsize,
                  // ),
                  // ButtonField(
                  //
                  //   text: 'التَّقْوى',
                  // ),
                  // SizedBox(
                  //   height: boxsize,
                  // ),
                  // ButtonField(
                  //
                  //   text: ' اليقينِ والتَّوكُّلِ',
                  // ),
                  // SizedBox(
                  //   height: boxsize,
                  // ),
                  // ButtonField(
                  //
                  //   text: 'المُرَاقَبَةُ',
                  // ),
                  // SizedBox(
                  //   height: boxsize,
                  // ),
                  // ButtonField(
                  //
                  //   text: 'الاستقامةُ',
                  // ),
                  // SizedBox(
                  //   height: boxsize,
                  // ),
                  // ButtonField(
                  //
                  //   text: 'المجاهدة',
                  // ),
                  // SizedBox(
                  //   height: boxsize,
                  // ),
                  // ButtonField(
                  //   onPressed: (){},
                  //   text: 'كَثْرةُ طُرُقِ الخيرِ',
                  // ),
                  // SizedBox(
                  //   height: boxsize,
                  // ),
                  // ButtonField(
                  //   onPressed: (){},
                  //   text: 'الاقتصادُ في العبادةِ',
                  // ),
                  // SizedBox(
                  //   height: boxsize,
                  // ),
                  // ButtonField(
                  //   onPressed: (){},
                  //   text: 'الرُّخَصُ الشرعيَّة: أحكامُها وضوابِطُها',
                  // ),
                  // SizedBox(
                  //   height: boxsize,
                  // ),
                  // ButtonField(
                  //   onPressed: (){},
                  //   text: 'السُّنَّة النبوية الشريفة',
                  // ),
                  // SizedBox(
                  //   height: boxsize,
                  // ),
                  // ButtonField(
                  //   onPressed: (){},
                  //   text: 'المُرَاقَبَةُ',
                  // ),
                  // SizedBox(
                  //   height: boxsize,
                  // ),
                  // ButtonField(
                  //   onPressed: (){},
                  //   text: 'أقسام الحكم التكليفي للأمة',
                  // ),
                  // SizedBox(
                  //   height: boxsize,
                  // ),

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
        body: SfPdfViewer.network('https://www.vssut.ac.in/lecture_notes/lecture1423905560.pdf',
          enableTextSelection: true,
          onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
            if (details.selectedText == null && _overlayEntry != null) {
              _overlayEntry!.remove();
              _overlayEntry = null;
            } else if (details.selectedText != null && _overlayEntry == null) {
              _showContextMenu(context, details);

            }
          },
          controller: _pdfViewerController,),
        // body: SfPdfViewer.asset('images/elsalehen2.pdf'),
      ),
    );
  }
}
