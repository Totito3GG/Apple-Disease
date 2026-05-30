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
  static const int _inputSize = 380;
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
    assert(isLoaded, 'Classifier not loaded');

    final rawBytes = await imageFile.readAsBytes();
    img.Image? decoded = img.decodeImage(rawBytes);
    if (decoded == null) throw Exception('Image illisible');

    final resized = img.copyResize(decoded, width: _inputSize, height: _inputSize);
    final inputData = _imageToFloat32List(resized);

    // Input shape: [1, 380, 380, 3]
    final input = inputData.reshape([1, _inputSize, _inputSize, 3]);

    // Output shape: [1, numClasses]
    final numClasses = _labels.length;
    final outputData = Float32List(numClasses);
    final output = outputData.reshape([1, numClasses]);

    _interpreter!.run(input, output);

    final probs = List<double>.from(outputData);
    double maxVal = probs[0];
    int maxIdx = 0;
    for (int i = 1; i < probs.length; i++) {
      if (probs[i] > maxVal) {
        maxVal = probs[i];
        maxIdx = i;
      }
    }

    return ClassifierResult(
      className: _labels[maxIdx],
      confidence: maxVal,
    );
  }

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
