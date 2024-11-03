import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../providers/flip_card_provider.dart';

class CardPrinter {
// Method to capture widget to image with higher pixel ratio
  Future<ui.Image> _captureWidget(GlobalKey key,
      {double pixelRatio = 8.0}) async {
    await SchedulerBinding.instance.endOfFrame;

    RenderRepaintBoundary? boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    if (boundary != null) {
      return await boundary.toImage(
          pixelRatio: pixelRatio); // Increase pixel ratio for better quality
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

  // Method to generate PDF containing both front and back sides with improved image quality
  Future<void> generatePDF(
    BuildContext context,
    GlobalKey frontKey,
    GlobalKey backKey,
  ) async {
    final card = Provider.of<FlipCardProvider>(context, listen: false);
    final pdf = pw.Document();

    // Capture the front and back card widgets as high-quality images
    final frontImage =
        await _captureWidget(frontKey); // Adjust pixel ratio as needed
    card.toggleFlip();
    await Future.delayed(Duration(milliseconds: 2000));
    final backImage = await _captureWidget(backKey);
    card.toggleFlip();

    // Convert images to high-quality PDF images
    final frontPdfImage = await _convertToPdfImage(frontImage, pdf);
    final backPdfImage = await _convertToPdfImage(backImage, pdf);

    // Set standard ID card size
    const cardHeight = 85.6 * PdfPageFormat.mm;
    const cardWidth = 53.98 * PdfPageFormat.mm;

    // Create a page with both front and back cards side by side
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
                child: pw.FittedBox(
                  fit: pw.BoxFit.contain,
                  child: pw.Image(frontPdfImage),
                ),
              ),
              pw.SizedBox(width: 10),
              pw.Container(
                width: cardWidth,
                height: cardHeight,
                child: pw.FittedBox(
                  fit: pw.BoxFit.contain,
                  child: pw.Image(backPdfImage),
                ),
              ),
            ],
          );
        },
      ),
    );

    // Request storage permissions
    await _requestPermissions();

    // Save to custom folder
    const folderPath = '/storage/emulated/0/Card Maker';
    final folder = Directory(folderPath);
    if (!(await folder.exists())) {
      await folder.create(recursive: true);
    }

    // File path with timestamp
    String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final filePath = '$folderPath/ID_Card_$timestamp.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Toast message for confirmation
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
