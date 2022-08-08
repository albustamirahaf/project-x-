import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:massages_app/screens/registration_screens.dart';
import 'package:massages_app/screens/signin_screen.dart';

import '../widgets/my_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = "welcome_screen";
  const WelcomeScreen({Key? key}) : super(key: key);


  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                ),
                Text(
                  "Massegeme",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Color(0xAA),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            myButton(
              color: Colors.yellow[900]!,
              title: "sign in",
              onpressed: () {
                Navigator.pushNamed(context, SignInScreen.screenRoute)
                ;
              },
            ),
            myButton(
              color: Colors.blue[800]!,
              title: 'register',
              onpressed: () {
                Navigator.pushNamed(context, registrationscreens.screenRoute)
                ;
              },
            )
          ],
        ),
      ),
    );
  }
}
