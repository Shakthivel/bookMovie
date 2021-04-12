import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  PageDecoration pageDecoration = const PageDecoration(
    titleTextStyle: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    ),
    bodyTextStyle: TextStyle(fontSize: 19.0),
    descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    pageColor: Colors.white,
    imagePadding: EdgeInsets.zero,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Select Movie",
          body: "Select the movie you want to watch from the app.",
          image: SvgPicture.asset("assets/images/onBoard1.svg"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Take Seats!",
          body: "Book your preffered seats from the seats available.",
          image: SvgPicture.asset("assets/images/onBoard2.svg"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Watch & Enjoy",
          body: "Enjoy watching the movie at the theatre booked",
          image: SvgPicture.asset("assets/images/onBoard4.svg"),
          decoration: pageDecoration,
        ),
      ],
      showNextButton: true,
      next: Text('Next'),
      showSkipButton: true,
      skip: const Text("Skip"),
      onSkip: () {
        Navigator.of(context).pushReplacementNamed('/user');
      },
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () {
        Navigator.of(context).pushReplacementNamed('/user');
      },
    ));
  }
}
