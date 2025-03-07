import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
    final backendUrl = dotenv.env['BACKEND_URL'];

    if (backendUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Backend URL not set')),
      );
      setIsSending(false);
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(backendUrl),
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
      final responseData = jsonDecode(response.body);

      if (responseData['result'] == true) {
        showSuccessDialog();
      } else {
        throw Exception(responseData['error']);
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
