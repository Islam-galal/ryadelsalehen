// ignore_for_file: must_be_immutable, depend_on_referenced_packages, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ryadelsalehen/helper/widgets_helper.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CustomAppBarLeading extends StatelessWidget {
  CustomAppBarLeading(
      {required this.previewContainer,
      required this.bookMarkCaption,
      required this.bookmarkskey,
      required this.textController,
      required this.pdfViewerController,
      required this.originalSize});
  GlobalKey previewContainer;
  String bookMarkCaption;
  String bookmarkskey;
  TextEditingController textController;
  PdfViewerController pdfViewerController;
  int originalSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.bookmark_border),
              onPressed: () async {
                bookMarkCaption = null.toString();
                await Hive.initFlutter();
                var box = await Hive.openBox(bookmarkskey);

                box = box;

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
          // search buttom
          child: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Helper().openDialogToPage(
                snakBarDuration: 4,
                buildContext: context,
                textEditingControll: textController,
                pdfViewerController: pdfViewerController,
              );
            },
          ),
        ),
      ],
    );
  }
}
