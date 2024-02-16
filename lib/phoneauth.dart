import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/optscreen.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Auth"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Enter your phone number",
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException ex) {},
                    codeSent: (String verificationId, int? resendToken) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPscreen(verificationid: verificationId,)));

                    },
                    codeAutoRetrievalTimeout: (String verficationid) {},
                    phoneNumber: phoneController.text.toString());
              },
              child: Text("verify Phone Number"))
        ],
      ),
    );
  }
}
