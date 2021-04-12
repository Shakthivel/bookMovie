import 'package:book_movie/controller/firebase.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toast/toast.dart';
import 'package:firebase_database/firebase_database.dart';

import '../constants/BOXSTYLES.dart';
import '../constants/COLORS.dart';
import '../constants/TEXTSTYLES.dart';
import '../widgets/singInUpDecoration.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final fb = FirebaseDatabase.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  OverlayEntry _progressOverlay = OverlayEntry(
      builder: (context) => Stack(
            children: [
              Container(color: Colors.white),
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          ),
      opaque: true);
  @override
  Widget build(BuildContext context) {
    final ref = fb.reference();
    return Scaffold(
      body: SingleChildScrollView(
        child: SignInUpDecoration(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 25, 8, 20),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Email:",
                  style: label_style,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: inputFieldDec,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Password:",
                  style: label_style,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: inputFieldDec,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: shadowButton(
                        bText: "Sign In",
                        bTextSize: 20,
                        bTextWeight: FontWeight.w700,
                        bradius: 15,
                        shadow: 8,
                        color: Colors.white,
                      ),
                      onTap: () async {
                        Overlay.of(context).insert(_progressOverlay);
                        User user;
                        String role;
                        try {
                          user = (await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                            email: "def@gmail.com",
                            password: "asdfghjkl",
                          ))
                              .user;
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            Toast.show("No user found for that email.", context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                          } else if (e.code == 'wrong-password') {
                            Toast.show('Wrong password provided for that user.',
                                context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                          }
                        }
                        if (user != null) {
                          await ref
                              .child("users")
                              .child(user.uid.toString())
                              .child('role')
                              .once()
                              .then((DataSnapshot data) {
                            role = data.value.toString();
                          });
                          print(role);
                          if (role == "user")
                            Navigator.of(context).pushNamed('/user');
                          else
                            Navigator.of(context).pushNamed('/admin');
                          _progressOverlay.remove();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
