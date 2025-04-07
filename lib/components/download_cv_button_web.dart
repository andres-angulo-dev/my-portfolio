import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../utils/global_others.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html; // Import dart:html for web download

class DownloadCvButton extends StatelessWidget {
  const DownloadCvButton({super.key});

  // Function to handle CV download for web
  Future<void> _downloadCV(BuildContext context) async {
    try {
      // Load the file from assets
      final byteData = await rootBundle.load(AppImages.cvAndresAngulo);

      // Convert ByteData to Uint8List
      final Uint8List data = byteData.buffer.asUint8List();

      // Create a blob and a link element
      final blob = html.Blob([data], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Create an anchor element and trigger the download
      html.AnchorElement(
        href: url
      )
        ..setAttribute('download', 'cv_Andrés_Angulo.pdf')
        ..click();  // This line initiates the download

      // Revoke the object URL to free memory
      html.Url.revokeObjectUrl(url);
    } catch (error) {
      if (context.mounted) {
        _showDialog(context, 'Error', 'Error: $error');
      }
    }
  }

  // Function to show a dialog with a message
  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _downloadCV(context),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        minimumSize: Size(900, 50),
      ),
      child: Text(
        'Télécharger mon CV', 
        style: TextStyle(
          fontSize: 18
        ),
      ),
    );
  }
}
