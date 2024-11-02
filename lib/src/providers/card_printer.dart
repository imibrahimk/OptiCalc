import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:opticalc/src/providers/flip_card_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class CardPrinter {
// Method to capture widget to image
  Future<ui.Image> _captureWidget(GlobalKey key) async {
    // Ensure the widget is rendered in the next frame
    await SchedulerBinding.instance.endOfFrame;

    RenderRepaintBoundary? boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    if (boundary != null) {
      // Ensure the widget has a valid size and boundary to capture
      return await boundary.toImage(pixelRatio: 3.0);
    } else {
      throw Exception('Unable to capture image, the widget is not ready.');
    }
  }

  // Convert captured image to PDF image
  Future<pw.ImageProvider> _convertToPdfImage(
      ui.Image uiImage, pw.Document pdf) async {
    ByteData? byteData =
        await uiImage.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();
    return pw.MemoryImage(pngBytes);
  }

  // Method to generate PDF containing both front and back sides
  Future<void> generatePDF(
    BuildContext context,
    GlobalKey frontKey,
    GlobalKey backKey,
  ) async {
    // For card flip access
    final card = Provider.of<FlipCardProvider>(context, listen: false);

    final pdf = pw.Document();

    // Capture the front and back card widgets as images
    final frontImage = await _captureWidget(frontKey);

    card.toggleFlip();

    await Future.delayed(Duration(milliseconds: 2000));

    final backImage = await _captureWidget(backKey);

    card.toggleFlip();

    // Convert to PDF image
    final frontPdfImage = await _convertToPdfImage(frontImage, pdf);
    final backPdfImage = await _convertToPdfImage(backImage, pdf);

    // Set standard ID card size: 85.6mm x 53.98mm
    const cardHeight = 85.6 * PdfPageFormat.mm;
    const cardWidth = 53.98 * PdfPageFormat.mm;

    // Create a page with both front and back card side by side
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Container(
                width: cardWidth,
                height: cardHeight,
                child: pw.Image(frontPdfImage),
              ),
              pw.SizedBox(width: 10), // Space between cards
              pw.Container(
                width: cardWidth,
                height: cardHeight,
                child: pw.Image(backPdfImage),
              ),
            ],
          );
        },
      ),
    );

    // Request storage permissions
    await _requestPermissions();

    // Define custom folder path in root directory 0/
    const folderPath = '/storage/emulated/0/Card Maker';
    final folder = Directory(folderPath);

    // Create folder if it doesn't exist
    if (!(await folder.exists())) {
      await folder.create(recursive: true);
    }

    // Get current date and time to append to the file name
    String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

    // Save the PDF file with date and time in the file name
    final filePath = '$folderPath/ID_Card_$timestamp.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Show toast with file path
    Fluttertoast.showToast(
      msg: "PDF saved at: $filePath",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  Future<void> _requestPermissions() async {
    // Request storage permission for Android
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }

    // On Android 10 and above, manage external storage permission might be needed
    if (await Permission.manageExternalStorage.isDenied) {
      await Permission.manageExternalStorage.request();
    }
  }
}
