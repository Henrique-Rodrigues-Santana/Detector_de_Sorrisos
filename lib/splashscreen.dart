import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:detectordesorrisos/home.dart';

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: Home(),
      title: Text("Analize Facial Simples",style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.white),
      ), 
      image: Image.asset("assets/kjh.jpg"),
      backgroundColor: Colors.blueAccent,
      photoSize: 100,
      loaderColor: Colors.white,

    );
  }
}
