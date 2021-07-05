import 'package:detectordesorrisos/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Detector de Sorrisos",
      home: MySplash(),
      debugShowCheckedModeBanner: false,
    );
  }
}