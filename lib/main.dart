import 'package:flutter/material.dart';

import 'Auth/signup.dart';


const api = 'https://genorion1.herokuapp.com/';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: const SignUpScreen(),
    );
  }
}
