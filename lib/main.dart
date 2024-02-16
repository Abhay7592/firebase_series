import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_series/loginpage.dart';
import 'package:firebase_series/showdata.dart';
import 'package:flutter/material.dart';

import 'checkuser.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          "AIzaSyAZevwCtCEpUqS2pSYL7DhQ08QaBEUcAfc", // paste your api key here
      appId:
          "1:1012463725078:android:439729b29f5b6974d8e337", //paste your app id here
      messagingSenderId: "1012463725078", //paste your messagingSenderId here
      projectId: "fir-series-60448", //paste your project id here
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const CheckUser(),
      // home: PhoneAuth(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  logout() async {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyHomepage"),
        centerTitle: true,
        backgroundColor: Colors.black38,
        leading: Icon(Icons.supervised_user_circle),
        elevation:1,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    logout();
                  },
                  icon: Icon(Icons.logout)),

            ],
          )
        ],
      ),
      body: ShowData(),
    );
  }
}
