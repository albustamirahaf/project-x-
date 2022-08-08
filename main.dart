import 'package:flutter/material.dart';
import 'package:massages_app/screens/chat_screen.dart';
import 'package:massages_app/screens/registration_screens.dart';
import 'package:massages_app/screens/signin_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
    MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'masseges app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: ChatScreen(),
      initialRoute: _auth.currentUser != null
          ? ChatScreen.screenRoute
          : WelcomeScreen.screenRoute,
      routes: {
        WelcomeScreen.screenRoute: (context) => WelcomeScreen(),
        SignInScreen.screenRoute: (context) => SignInScreen(),
        registrationscreens.screenRoute: (context) => registrationscreens(),
        ChatScreen.screenRoute: (context) => ChatScreen(),
      },
    );
  }
}
