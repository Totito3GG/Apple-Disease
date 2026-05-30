import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/classifier.dart';
import 'result_screen.dart';
import 'guide_screen.dart';

class HomeScreen extends StatefulWidget {
  final AppleClassifier classifier;
  final String lang;
  final VoidCallback onToggleLang;

  const HomeScreen({
    super.key,
    required this.classifier,
    required this.lang,
    required this.onToggleLang,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _picker = ImagePicker();
  bool _loading = false;

  bool get _isAr => widget.lang == 'ar';

  String _t(String fr, String ar) => _isAr ? ar : fr;

  Future<void> _pickAndAnalyze(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      imageQuality: 90,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    if (picked == null || !mounted) return;

    setState(() => _loading = true);
    try {
      final result = await widget.classifier.classify(File(picked.path));
      if (!mounted) return;
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            imageFile: File(picked.path),
            result: result,
            lang: widget.lang,
            onToggleLang: widget.onToggleLang,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_t('Erreur : $e', 'خطأ: $e'))),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Directionality(
      textDirection: _isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: cs.surface,
        appBar: AppBar(
          backgroundColor: cs.primary,
          foregroundColor: Colors.white,
          title: Text(
            _t('🍎 Maladies du Pommier', '🍎 أمراض التفاح'),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: widget.onToggleLang,
              child: Text(
                _isAr ? 'FR' : 'ع',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        body: _loading ? _buildLoading() : _buildBody(cs),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(strokeWidth: 4),
          const SizedBox(height: 24),
          Text(
            _t('Analyse en cours…', 'جارٍ التحليل…'),
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(ColorScheme cs) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Icône principale
          Center(
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('🍎', style: TextStyle(fontSize: 72)),
              ),
            ),
          ),
          const SizedBox(height: 28),

          Text(
            _t('Photographiez une feuille\nou un fruit de pommier',
               'صوّر ورقة أو ثمرة\nمن شجرة التفاح'),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, height: 1.5),
          ),
          const SizedBox(height: 12),
          Text(
            _t("L'analyse est locale - aucune connexion internet requise",
               'التحليل محلي - لا يتطلب اتصالاً بالإنترنت'),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: cs.outline),
          ),
          const SizedBox(height: 40),

          // Bouton caméra
          ElevatedButton.icon(
            onPressed: () => _pickAndAnalyze(ImageSource.camera),
            icon: const Icon(Icons.camera_alt_rounded, size: 30),
            label: Text(_t('📷  Prendre une photo', '📷  التقاط صورة')),
            style: ElevatedButton.styleFrom(
              backgroundColor: cs.primary,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          // Bouton galerie
          ElevatedButton.icon(
            onPressed: () => _pickAndAnalyze(ImageSource.gallery),
            icon: const Icon(Icons.photo_library_rounded, size: 30),
            label: Text(_t('🖼️  Choisir depuis la galerie', '🖼️  اختر من المعرض')),
            style: ElevatedButton.styleFrom(
              backgroundColor: cs.secondaryContainer,
              foregroundColor: cs.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: 40),

          const Divider(),
          const SizedBox(height: 16),

          // Bouton guide
          OutlinedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => GuideScreen(
                  lang: widget.lang,
                  onToggleLang: widget.onToggleLang,
                ),
              ),
            ),
            icon: const Icon(Icons.menu_book_rounded, size: 26),
            label: Text(
              _t('📖  Guide des maladies', '📖  دليل الأمراض'),
              style: const TextStyle(fontSize: 18),
            ),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(58),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
          ),
          const SizedBox(height: 32),

          // Indication précision
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.primaryContainer.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _t(
                '🤖 Modèle EfficientNet-B4\nPrécision cible ≥ 95%\n4 classes détectées',
                '🤖 نموذج EfficientNet-B4\nدقة مستهدفة ≥ 95%\n4 فئات مكتشفة',
              ),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: cs.onPrimaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}
