import 'package:flutter/material.dart';
import 'package:milestone2/pages/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:milestone2/pages/Sign_up.dart';
//import 'package:milestone1/pages/account_page.dart';
//import 'package:milestone1/pages/home_page.dart';
//import 'package:milestone1/pages/payment_page.dart';
//import 'package:milestone1/pages/mytrips_page.dart';
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }

}



