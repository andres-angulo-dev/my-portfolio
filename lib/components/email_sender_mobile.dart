import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> sendEmail(
  { required GlobalKey<FormState> formKey,
    required BuildContext context,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required TextEditingController emailController,
    required TextEditingController companyController,
    required TextEditingController phoneController,
    required TextEditingController messageController,
    required Function showSuccessDialog,
    required Function setIsSending }) async {
  setIsSending(true);

  if (formKey.currentState!.validate()) {
    try {
      final smtpServer = SmtpServer(
        dotenv.env['MAILTRAP_HOST']!,
        port: int.parse(dotenv.env['MAILTRAP_PORT']!),
        ssl: true,
        ignoreBadCertificate: true,
        username: dotenv.env['MAILTRAP_USERNAME'],
        password: dotenv.env['MAILTRAP_PASSWORD'],
      );

      final message = Message()
        ..from = Address(dotenv.env['MAILTRAP_FROM']!, '${firstNameController.text} ${lastNameController.text}')
        ..recipients.add(dotenv.env['MAILTRAP_TO']!)
        ..subject = 'New contact message by ${lastNameController.text}'
        ..text = 'LastName: ${lastNameController.text}\n'
            'FirstName: ${firstNameController.text}\n'
            'Company: ${companyController.text}\n'
            'Phone: ${phoneController.text}\n'
            '${messageController.text}';

      await send(message, smtpServer);
      showSuccessDialog();
    } on MailerException catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send email: ${error.message}')),
      );
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}')),
      );
    } finally {
      setIsSending(false);
    }
  } else {
    setIsSending(false);
  }
}
