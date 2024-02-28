import 'package:flutter/material.dart';
import 'dart:async';  // Import this for Future.delayed


import 'checkuser.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add this code to navigate after 5 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => CheckUser(),
          transitionsBuilder: (context, animation1, animation2, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutCirc;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation1.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Splash Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset("assets/flutter.png", height: 100, width: 100),
                Image.asset("assets/FIrebase (3).png", height: 100, width: 100,)
              ],

            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Flutter Firebase",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  wordSpacing: 2,
                  color: Colors.blue),
            ),
            const SizedBox(
              height: 30,
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(context,MaterialPageRoute(builder: (context)=> CheckUser()));
            //     },
            //     child: const Text("Check User"))
          ],
        ),
      ),
    );
  }
}
