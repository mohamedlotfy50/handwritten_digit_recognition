import 'dart:ui';

import '../provider/drawer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawingBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DrawerProvider _provider = Provider.of<DrawerProvider>(context);
    final Size _size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        final Offset currentOffset = details.localPosition;
        _provider.addOffset(
          currentOffset,
          _size.width,
        );
      },
      onPanEnd: (_) {
        _provider.predect(_size.width);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(2),
        width: 300,
        height: 300,
        color: Colors.black,
        child: CustomPaint(
          size: Size(300, 300),
          painter: Pen(_provider),
        ),
      ),
    );
  }
}

class Pen extends CustomPainter {
  final DrawerProvider provider;

  Pen(this.provider) : super(repaint: provider);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 7.5
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < provider.offsets.length - 1; i++) {
      canvas.drawLine(provider.offsets[i], provider.offsets[i + 1], paint);
    }

    // canvas.drawPoints(PointMode.points, provider.offsets, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
