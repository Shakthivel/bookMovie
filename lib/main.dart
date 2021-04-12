import 'package:flutter/material.dart';

import './screens/onBoarding.dart';
import './screens/login.dart';
import './screens/user/home.dart';

void main() {
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
          '/login': (context) => LoginScreen(),
          '/user': (context) => UserHomeScreen(),
        });
  }
}
