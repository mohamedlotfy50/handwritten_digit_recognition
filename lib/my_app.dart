import 'package:digit_recognizer/screens/canvas_board.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digit recognizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CanvasBoard(),
    );
  }
}
