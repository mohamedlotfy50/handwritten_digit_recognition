import 'dart:convert';
import 'dart:typed_data';

import '../models/prediction_model.dart';
import 'package:image/image.dart';
import 'package:tflite/tflite.dart';

import 'canvas_to_image.dart';

class DigitRecognizerTFlite {
  CanvasToImage _canvasToImage = CanvasToImage();

  Future<String?> loadModel() async {
    return Tflite.loadModel(
      numThreads: 2,
      model: 'assets/model/digits_recognition.tflite',
      labels: 'assets/model/digits_recognition.txt',
    );
  }

  Future<List<Predection>> predict(Uint8List image) async {
    List<Predection>? predect;
    final output = await Tflite.runModelOnBinary(
      binary: image,
      asynch: true,
    );
    predect = output?.map((element) => Predection.fromMap(element)).toList();
    // print(element.runtimeType);

    return predect ?? [];
  }
}
