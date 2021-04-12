import 'package:book_movie/screens/admin/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/onBoarding.dart';
import './screens/login.dart';
import './screens/user/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: OnBoardingScreen(),
        routes: {
          '/login': (context) => Login(),
          '/user': (context) => UserHomeScreen(),
          '/admin': (context) => AdminHomeScreen(),
        });
  }
}
