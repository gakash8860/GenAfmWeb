import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Auth/signup.dart';

const api = 'https://genorion1.herokuapp.com/';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCIZzoLcvos2paxQ2GxHMGtmK5IrFpn8kc",
            authDomain: "genorionafm.firebaseapp.com",
            projectId: "genorionafm",
            storageBucket: "genorionafm.appspot.com",
            messagingSenderId: "454100345329",
            appId: "1:454100345329:web:d476f2b8d9c25e975ce450",
            measurementId: "G-G7J2SNK6XC"));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Genorion Afm',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignUpScreen(),
    );
  }
}
