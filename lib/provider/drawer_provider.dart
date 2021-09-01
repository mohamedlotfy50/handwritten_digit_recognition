import 'dart:typed_data';

import '../models/prediction_model.dart';
import '../utils/canvas_to_image.dart';
import '../utils/digit_recognizer_tflite.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class DrawerProvider extends ChangeNotifier {
  List<Offset> offsets = [];
  CanvasToImage _canvasToImage = CanvasToImage();
  DigitRecognizerTFlite _digitRecognizerTFlite = DigitRecognizerTFlite();
  List<Predection>? _predection;

  List<Predection> get predection => _predection ?? [];

  DrawerProvider() {
    _digitRecognizerTFlite.loadModel();
  }
  void addOffset(
    Offset currentOffset,
    double width,
  ) {
    if (currentOffset > Offset.zero &&
        currentOffset < Offset(width / 1.2, width / 1.2)) {
      offsets.add(currentOffset);
      notifyListeners();
    }
  }

  void clearTheBoard() {
    offsets.clear();
    _predection = [];
    notifyListeners();
  }

  Future predect(double size) async {
    final image = await _canvasToImage.canvasToPicture(offsets, 300);
    final x = await _canvasToImage.imageToByteListFloat32(image, 28);
    _predection = await _digitRecognizerTFlite.predict(x);
    notifyListeners();
  }
}
