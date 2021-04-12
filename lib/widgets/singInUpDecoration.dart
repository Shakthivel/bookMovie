import '../constants/COLORS.dart';
import '../constants/TEXTSTYLES.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInUpDecoration extends StatelessWidget {
  final Widget child;
  SignInUpDecoration({this.child});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            'assets/images/onBoard4.svg',
            fit: BoxFit.cover,
            placeholderBuilder: (context) => Container(
              padding: const EdgeInsets.all(30.0),
              width: double.infinity,
              height: 220,
              child: Center(
                child: const CircularProgressIndicator(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Container(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 20.0,
            ),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              boxShadow: [
                new BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            width: double.infinity,
            child: child,
          ),
        ),
      ],
    );
  }
}
