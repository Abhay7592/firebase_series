import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/forgotpassword.dart';
import 'package:firebase_series/main.dart';
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
            .then((value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(title: "Myhomepage"))));
      } on FirebaseAuthException catch (ex) {
        return UiHelper.CustomeAlertBox(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
        backgroundColor: Colors.black12,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailController, "Email", Icons.mail, false),
          UiHelper.CustomTextField(
              passwordController, "password", Icons.password, true),
          SizedBox(
            height: 30,
          ),
          UiHelper.CustomeButton(() {
            login(emailController.text.toString(),
                passwordController.text.toString());
          }, "Login"),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an Account??",
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ForgotPassword()));
            },
            child: Text("Forgot Password??", style: TextStyle(fontSize: 20)),
          )
        ],
      ),
    );
  }
}
