// ignore_for_file: depend_on_referenced_packages, unnecessary_import

import 'package:flutter/material.dart';
import 'package:ryadelsalehen/helper/widgets_helper.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class SyncfusionPdfViewerWidget extends StatelessWidget {
  SyncfusionPdfViewerWidget(
      {super.key,
      required this.pdfPath,
      required this.zoom,
      required this.padding,
      required this.previewContainer,
      required this.pdfViewerKey,
      required this.pdfViewerController,
      required this.currentPage});

  final String pdfPath;
  final double zoom;
  final double padding;
  final GlobalKey previewContainer;
  final GlobalKey<SfPdfViewerState> pdfViewerKey;
  PdfViewerController pdfViewerController;
  late int currentPage;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(bottom: padding),
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
                  pdfPath,
                  key: pdfViewerKey,
                  canShowScrollHead: false,
                  controller: pdfViewerController,
                  enableTextSelection: false,
                  scrollDirection: PdfScrollDirection.horizontal,
                  onPageChanged: (PdfPageChangedDetails details) {
                    currentPage = pdfViewerController.pageNumber;
                    Helper().saveIntegerToLocalStorage(
                        key: 'currentPage', value: currentPage);
                  },
                  currentSearchTextHighlightColor: Colors.blue.withOpacity(0.6),
                  otherSearchTextHighlightColor: Colors.blue.withOpacity(0.3),
                  initialZoomLevel: zoom,
                  pageLayoutMode: PdfPageLayoutMode.single,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
