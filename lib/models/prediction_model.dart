import 'dart:convert';

class Predection {
  final int index;
  final double confidence;

  Predection({required this.index, required this.confidence});

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'confidence': confidence,
    };
  }

  factory Predection.fromMap(Map<dynamic, dynamic> map) {
    return Predection(
      index: map['index'],
      confidence: map['confidence'],
    );
  }

  String toJson() => json.encode(toMap());
}
