import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/uihelper.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  forgotPassword(String email) async {
    if (email == "") {
      return UiHelper.CustomeAlertBox(
          context, "Enter an email to reset Password");
    } else {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailController, "Email", Icons.mail, false),
          const SizedBox(
            height: 20,
          ),
          UiHelper.CustomeButton(() {
            forgotPassword(emailController.text.toString());
          }, "Reset Password")
        ],
      ),
    );
  }
}
