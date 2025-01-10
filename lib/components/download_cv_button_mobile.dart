import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import './permission_manager.dart';
import '../utils/global_others.dart';

class DownloadCvButton extends StatelessWidget {
  const DownloadCvButton({ super.key });

  // Function to handle CV download for mobile
  Future<void> _downloadCV(BuildContext context) async {
    try {
      // Request necessary permissions
      if (await PermissionManager.requestManageStoragePermission() ||
          await PermissionManager.requestStoragePermission()) {
        
        // Retrieve the public download directory
        io.Directory? directory = await getExternalStorageDirectory();
        if (directory != null) {
          String downloadsDirectoryPath = '/storage/emulated/0/Download';
          directory = io.Directory(downloadsDirectoryPath);
        }

        // Check if directory is available
        if (directory == null) {
          if (context.mounted) {
            _showDialog(context, 'Error', 'Download directory not found.');
          }
          return;
        }

        // Path to the destination file
        final filePath = '${directory.path}/cv_Andrés_Angulo.pdf';

        // Load the file from assets
        final byteData = await rootBundle.load(AppImages.cvAndresAngulo);

        // Write the file to the system
        final file = io.File(filePath);
        await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

        // Show success dialog
        if (context.mounted) {
          _showDialog(context, 'Document téléchargé avec succès !', 'Emplacement:\n$filePath');
        }
      } else {
        // Show permission denied dialog
        if (context.mounted) {
          _showDialog(context, 'Can\'t download file', 'Permission denied.');
        }
      }
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
      child: const Text('Télécharger mon CV'),
    );
  }
}
