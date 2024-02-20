import 'dart:io'; // Import the File class

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/main.dart';
import 'package:firebase_series/uihelper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? pickedImage;

  showAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          {
            return AlertDialog(
              title: const Text("Pick Image From"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    leading: const Icon(Icons.camera_alt),
                    title: const Text("Camera"),
                  ),
                  ListTile(
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    leading: const Icon(Icons.image),
                    title: const Text("Gallery"),
                  ),
                ],
              ),
            );
          }
        });
  }

  signUp(String email, String password) async {
    if (email == "" && password == "" && pickedImage == null) {
      UiHelper.CustomeAlertBox(context, "Enter Require Field");
    } else {
      UserCredential? userCredential;
      try {
        FirebaseFirestore.instance.collection("Users").doc("Email").set({
          "title": email,
        });

        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          uploadData();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const MyHomePage()));
        });
      } on FirebaseAuthException catch (ex) {
        return UiHelper.CustomeAlertBox(context, ex.code.toString());
      }
    }
  }

  uploadData() async {
    final storage = FirebaseStorage.instanceFor();

    UploadTask uploadTask = storage
        .ref("Profile Pics")
        .child(emailController.text.toString())
        .putFile(pickedImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(emailController.text.toString())
        .set({"Email": emailController.text.toString(), "Image": url}).then(
            (value) => print("User Uploaded"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up page"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                showAlertBox();
              },
              child: pickedImage != null
                  ? CircleAvatar(
                      radius: 80,
                      backgroundImage: FileImage(pickedImage!),
                    )
                  : const CircleAvatar(
                      radius: 80,
                      child: Icon(
                        Icons.person,
                        size: 80,
                      ),
                    ),
            ),
            UiHelper.CustomTextField(
                emailController, "Email", Icons.mail, false),
            UiHelper.CustomTextField(
                passwordController, "Password", Icons.password, true),
            const SizedBox(
              height: 30,
            ),
            UiHelper.CustomeButton(() {
              signUp(emailController.text.toString(),
                  passwordController.text.toString());
            }, "Sign Up")
          ],
        ));
  }

  pickImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (ex) {
      print(ex.toString());
    }
  }
}
