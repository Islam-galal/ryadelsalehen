import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ScrollButton extends StatelessWidget {
  const ScrollButton(
      {super.key,
      required this.direction,
      required this.onPressed,
      required this.padding});

  final PdfViewerController onPressed;
  final String text = '';
  final String direction;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        direction == 'LEFT' ? onPressed.previousPage() : onPressed.nextPage();
      },
      child: Padding(
        // padding: const EdgeInsets.all(20),
        padding: EdgeInsets.all(padding),
        child: Container(
          alignment: direction == 'LEFT'
              ? Alignment.bottomLeft
              : Alignment.bottomRight,
          child: Container(
            decoration: BoxDecoration(
                color: direction == 'LEFT'
                    ? const Color(0xFFDCE6FD)
                    : const Color(0xFF1856F5),
                borderRadius: BorderRadius.circular(30)),
            // color: Colors.red,
            width: 110,
            height: 50,
            child: direction == 'LEFT'
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Color(0xFF1856F5),
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'السابق ',
                        style: TextStyle(
                            fontFamily: 'Tajawal',
                            color: Color(0xFF1856F5),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'التالي',
                        style: TextStyle(
                            fontFamily: 'Tajawal',
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
    );
  }
}
