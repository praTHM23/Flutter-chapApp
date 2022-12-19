import 'package:chat_app/screens/authScreen.dart';
import 'package:chat_app/screens/chatscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduKart',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        platform: TargetPlatform.iOS,
        fontFamily: 'PatrickHand',
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return Chatscreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
