import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/forgotpassword.dart';
import 'package:firebase_series/main.dart';
import 'package:firebase_series/phoneauth.dart';
import 'package:firebase_series/signuppage.dart';
import 'package:firebase_series/uihelper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(String email, String password) async {
    if (email == "" && password == "") {
      return UiHelper.CustomeAlertBox(context, "Enter Require Field");
    } else {
      UserCredential? usercredential;

      try {
        usercredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MyHomePage())));
      } on FirebaseAuthException catch (ex) {
        return UiHelper.CustomeAlertBox(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
        backgroundColor: Colors.black12,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailController, "Email", Icons.mail, false),
          UiHelper.CustomTextField(
              passwordController, "password", Icons.password, true),
          const SizedBox(
            height: 30,
          ),
          UiHelper.CustomeButton(() {
            login(emailController.text.toString(),
                passwordController.text.toString());
          }, "Login"),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PhoneAuth()));
              },
              child: const Text("Login With PhoneNumber",
                  style: TextStyle(fontSize: 15))),
          const SizedBox(
            height: 20,
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an Account??",
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),

          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPassword()));
            },
            child:
                const Text("Forgot Password??", style: TextStyle(fontSize: 20)),
          )
        ],
      ),
    );
  }
}
