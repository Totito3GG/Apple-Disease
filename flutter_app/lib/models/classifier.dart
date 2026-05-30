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

    // Input: [1, 380, 380, 3] as nested List (tflite_flutter reads from the list directly)
    final input = [_buildInputTensor(resized)];

    // Output: [1, numClasses] — use List<List<double>> so the interpreter fills it in place
    final int numClasses = _labels.length;
    final List<List<double>> output = [List<double>.filled(numClasses, 0.0)];

    _interpreter!.run(input, output);

    // output[0] is now populated with probabilities
    final probs = output[0];

    int maxIdx = 0;
    double maxVal = probs[0];
    for (int i = 1; i < probs.length; i++) {
      if (probs[i] > maxVal) {
        maxVal = probs[i];
        maxIdx = i;
      }
    }

    return ClassifierResult(className: _labels[maxIdx], confidence: maxVal);
  }

  // Build [380][380][3] nested list — values in [0, 255] as EfficientNet expects
  List _buildInputTensor(img.Image image) {
    return List.generate(_inputSize, (y) =>
      List.generate(_inputSize, (x) {
        final pixel = image.getPixel(x, y);
        return [pixel.r.toDouble(), pixel.g.toDouble(), pixel.b.toDouble()];
      })
    );
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
  }
}
