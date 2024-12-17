import 'package:flutter/material.dart';
import '../components/email_sender.dart';  
import '../components/success_dialog_component.dart';
import '../components/form_contact_component.dart';
import '../utils/global_colors.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({ super.key });

  @override
  ContactScreenState createState() => ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _companyController.clear();
    _phoneController.clear();
    _messageController.clear();
    _formKey.currentState?.reset();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SuccessDialogComponent(
          onOkPressed: () {
            Navigator.of(context).pop();
          },
          resetForm: _resetForm,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact',
          style: TextStyle(
            color: GlobalColors.textColor,
            fontSize: 18.0,
          ),
        ),
        backgroundColor: GlobalColors.contactGradient1,
        iconTheme: IconThemeData(
          color: GlobalColors.textColor,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              GlobalColors.contactGradient1,
              GlobalColors.contactGradient2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormContactComponent(
            formKey: _formKey,
            firstNameController: _firstNameController,
            lastNameController: _lastNameController,
            emailController: _emailController,
            companyController: _companyController,
            phoneController: _phoneController,
            messageController: _messageController,
            isSending: _isSending,
            sendEmail: () => sendEmail(
              formKey: _formKey,
              context: context,
              firstNameController: _firstNameController,
              lastNameController: _lastNameController,
              emailController: _emailController,
              companyController: _companyController,
              phoneController: _phoneController,
              messageController: _messageController,
              showSuccessDialog: _showSuccessDialog,
              setIsSending: (value) {
                setState(() {
                  _isSending = value;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
