import 'package:digit_recognizer/provider/drawer_provider.dart';
import 'package:digit_recognizer/widgets/digits_row.dart';
import 'package:digit_recognizer/widgets/drawing_board.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CanvasBoard extends StatelessWidget {
  const CanvasBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (context) => DrawerProvider(),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Color(0xFF081b33),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Text(
                        'Digit Detector',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Draw any digit and the ai will try to guess \nthat digit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white54,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DrawingBoard(),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<DrawerProvider>().clearTheBoard();
                    },
                    icon: Icon(FontAwesomeIcons.eraser),
                    label: Text('Clean'),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  DigitsRow(start: 0, end: 5),
                  DigitsRow(start: 5, end: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
