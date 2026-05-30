import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class ClassifierResult {
  final String className;
  final double confidence;
  ClassifierResult({required this.className, required this.confidence});
}

class AppleClassifier {
  static const int _inputSize = 380; // EfficientNet-B4 : 380×380
  static const String _modelPath = 'assets/model/apple_disease_f16.tflite';
  static const String _labelsPath = 'assets/model/class_names.json';

  Interpreter? _interpreter;
  List<String> _labels = [];
  bool get isLoaded => _interpreter != null && _labels.isNotEmpty;

  Future<void> load() async {
    _interpreter = await Interpreter.fromAsset(_modelPath);

    final raw = await rootBundle.loadString(_labelsPath);
    _labels = List<String>.from(jsonDecode(raw));
  }

  Future<ClassifierResult> classify(File imageFile) async {
    assert(isLoaded, 'Classifier not loaded — call load() first');

    final rawBytes = await imageFile.readAsBytes();
    img.Image? decoded = img.decodeImage(rawBytes);
    if (decoded == null) throw Exception('Image illisible');

    // Resize à 380×380
    final resized = img.copyResize(decoded, width: _inputSize, height: _inputSize);

    // Normalisation [0, 255] — EfficientNetB4 normalise en interne via Rescaling
    final input = _imageToFloat32List(resized);

    // Sortie : [1, numClasses]
    final outputShape = _interpreter!.getOutputTensor(0).shape;
    final output = List.filled(outputShape[1], 0.0).reshape([1, outputShape[1]]);

    _interpreter!.run(input, output);

    final probs = List<double>.from(output[0] as List);
    final maxIdx = probs.indexWhere((p) => p == probs.reduce((a, b) => a > b ? a : b));

    return ClassifierResult(
      className: _labels[maxIdx],
      confidence: probs[maxIdx],
    );
  }

  // Convertit l'image en Float32List [1, 380, 380, 3]
  Float32List _imageToFloat32List(img.Image image) {
    final buffer = Float32List(_inputSize * _inputSize * 3);
    int idx = 0;
    for (int y = 0; y < _inputSize; y++) {
      for (int x = 0; x < _inputSize; x++) {
        final pixel = image.getPixel(x, y);
        buffer[idx++] = pixel.r.toDouble();
        buffer[idx++] = pixel.g.toDouble();
        buffer[idx++] = pixel.b.toDouble();
      }
    }
    return buffer;
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
  }
}
