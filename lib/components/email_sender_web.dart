import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      final response = await http.post(
        Uri.parse('https://my-portfolio-backend-oa2xug4t8-afas75s-projects.vercel.app/send_email'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'lastName': lastNameController.text,
          'firstName': firstNameController.text,
          'email': emailController.text,
          'company': companyController.text,
          'phone': phoneController.text,
          'message': messageController.text,
        }),
      );

      if (response.statusCode == 200) {
        showSuccessDialog();
      } else {
        throw Exception('Failed to send email');
      }
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
