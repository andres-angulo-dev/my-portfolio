import 'package:flutter/material.dart';
import '../screens/contact_screen.dart';

class SuccessDialogComponent extends StatelessWidget {
  final VoidCallback onOkPressed; // Callback for the OK button press.
  final VoidCallback resetForm; // Callback to reset the form.

  const SuccessDialogComponent({ super.key, required this.onOkPressed, required this.resetForm });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Succès'), // Title of the dialog.
      content: const Text('Votre message a bien été envoyé !'), // Message content of the dialog.
      actions: [
        TextButton(
          onPressed: () {
            resetForm(); // Reset the form when OK is pressed.
            Navigator.of(context).pop(); // Close the dialog.
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ContactScreen(), // Navigate to ContactScreen.
              ),
            );
          }, 
          child: const Text('OK'), // Label for the button.
        ),
      ],
    );
  }
}
