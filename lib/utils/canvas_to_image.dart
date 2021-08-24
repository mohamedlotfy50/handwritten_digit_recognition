import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class CanvasToImage {
  Future<ui.Image> canvasToPicture(List<Offset> offsets, double size) async {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Paint rectPaint = Paint()..color = Colors.black;
    // final Rect rect = Rect.fromLTWH(0, 0, size, size);
    final Paint digit = Paint()
      ..strokeCap = StrokeCap.round
      ..color = Colors.white
      ..strokeWidth = 7.5;
    final Canvas canvas = Canvas(recorder)..scale(28 / size);
    canvas.drawRect(Rect.fromLTWH(0, 0, size, size), rectPaint);

    for (int i = 0; i < offsets.length - 1; i++) {
      canvas.drawLine(offsets[i], offsets[i + 1], digit);
    }
    final ui.Picture picture = recorder.endRecording();

    final ui.Image image = await picture.toImage(28, 28);

    return image;
  }

  // Uint8List imageToByteListFloat32(
  //     ui.Image image, int inputSize, double mean, double std) {
  //   var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
  //   var buffer = Float32List.view(convertedBytes.buffer);
  //   int pixelIndex = 0;
  //   for (var i = 0; i < inputSize; i++) {
  //     for (var j = 0; j < inputSize; j++) {
  //       int pixel = im.getPixel(j, i);
  //       buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
  //       buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
  //       buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
  //     }
  //   }
  //   return convertedBytes.buffer.asUint8List();
  // }
  Future<Uint8List> imageToByteListFloat32(ui.Image img, int size) async {
    final ByteData? imgBytes = await img.toByteData();
    final resultBytes = Float32List(size * size);
    final buffer = Float32List.view(resultBytes.buffer);
    int index = 0;
    for (int i = 0; i < imgBytes!.lengthInBytes; i += 4) {
      final r = imgBytes.getUint8(i);
      final g = imgBytes.getUint8(i + 1);
      final b = imgBytes.getUint8(i + 2);
      buffer[index++] = (r + g + b) / 3.0 / 255.0;
    }

    return resultBytes.buffer.asUint8List();
  }

  Uint8List imageToByteListUint8(img.Image image, int inputSize) {
    var convertedBytes = Uint8List(1 * inputSize * inputSize * 3);
    var buffer = Uint8List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = img.getRed(pixel);
        buffer[pixelIndex++] = img.getGreen(pixel);
        buffer[pixelIndex++] = img.getBlue(pixel);
      }
    }
    return convertedBytes.buffer.asUint8List();
  }
}
