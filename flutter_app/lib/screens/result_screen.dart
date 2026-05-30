import 'dart:io';
import 'package:flutter/material.dart';
import '../models/classifier.dart';
import '../models/disease_data.dart';

class ResultScreen extends StatelessWidget {
  final File imageFile;
  final ClassifierResult result;
  final String lang;
  final VoidCallback onToggleLang;

  const ResultScreen({
    super.key,
    required this.imageFile,
    required this.result,
    required this.lang,
    required this.onToggleLang,
  });

  bool get _isAr => lang == 'ar';
  String _t(String fr, String ar) => _isAr ? ar : fr;

  @override
  Widget build(BuildContext context) {
    final cs      = Theme.of(context).colorScheme;
    final disease = kDiseaseData[result.className];
    final pct     = (result.confidence * 100).toStringAsFixed(1);
    final isOk    = disease?.isHealthy ?? false;
    final color   = isOk ? Colors.green.shade700 : Colors.red.shade700;
    final bgColor = isOk ? Colors.green.shade50  : Colors.red.shade50;

    return Directionality(
      textDirection: _isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: cs.primary,
          foregroundColor: Colors.white,
          title: Text(_t('Résultat', 'النتيجة'),
              style: const TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            TextButton(
              onPressed: onToggleLang,
              child: Text(_isAr ? 'FR' : 'ع',
                  style: const TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Photo analysée
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  imageFile,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // Verdict principal
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color, width: 2),
                ),
                child: Column(
                  children: [
                    Text(disease?.emoji ?? '❓',
                        style: const TextStyle(fontSize: 56)),
                    const SizedBox(height: 8),
                    Text(
                      _isAr
                          ? (disease?.nameAr ?? result.className)
                          : (disease?.nameFr ?? result.className),
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: color),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    // Barre de confiance
                    LinearProgressIndicator(
                      value: result.confidence,
                      color: color,
                      backgroundColor: Colors.grey.shade300,
                      minHeight: 10,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _t('Confiance : $pct%', 'الثقة: $pct%'),
                      style: TextStyle(fontSize: 16, color: color),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              if (disease != null) ...[
                // Description
                _Section(
                  icon: Icons.info_outline,
                  title: _t('Description', 'الوصف'),
                  child: Text(
                    _isAr ? disease.descAr : disease.descFr,
                    style: const TextStyle(fontSize: 15, height: 1.6),
                  ),
                ),
                const SizedBox(height: 12),

                // Symptômes
                if (!disease.isHealthy)
                  _Section(
                    icon: Icons.search,
                    title: _t('Symptômes', 'الأعراض'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: (_isAr
                              ? disease.symptomesAr
                              : disease.symptomesFr)
                          .map((s) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Row(children: [
                                  const Text('• ', style: TextStyle(fontSize: 16)),
                                  Expanded(
                                      child: Text(s,
                                          style:
                                              const TextStyle(fontSize: 15))),
                                ]),
                              ))
                          .toList(),
                    ),
                  ),
                const SizedBox(height: 12),

                // Traitements
                _Section(
                  icon: Icons.healing_rounded,
                  title: _t('Traitements recommandés', 'العلاجات الموصى بها'),
                  color: isOk ? Colors.green.shade100 : Colors.orange.shade50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: (_isAr
                            ? disease.traitementsAr
                            : disease.traitementsFr)
                        .asMap()
                        .entries
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isOk
                                          ? Colors.green
                                          : Colors.orange.shade700,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text('${e.key + 1}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(e.value,
                                        style: const TextStyle(fontSize: 15)),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.camera_alt_rounded),
                label: Text(_t('Analyser une autre photo',
                    'تحليل صورة أخرى')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  final Color? color;

  const _Section({
    required this.icon,
    required this.title,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(title,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
