import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/classifier.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final lang  = prefs.getString('lang') ?? 'fr';

  final classifier = AppleClassifier();
  await classifier.load();

  runApp(AppleDiseaseApp(classifier: classifier, initialLang: lang));
}

class AppleDiseaseApp extends StatefulWidget {
  final AppleClassifier classifier;
  final String initialLang;

  const AppleDiseaseApp({
    super.key,
    required this.classifier,
    required this.initialLang,
  });

  @override
  State<AppleDiseaseApp> createState() => _AppleDiseaseAppState();
}

class _AppleDiseaseAppState extends State<AppleDiseaseApp> {
  late String _lang;

  @override
  void initState() {
    super.initState();
    _lang = widget.initialLang;
  }

  void _toggleLang() async {
    final next = _lang == 'fr' ? 'ar' : 'fr';
    setState(() => _lang = next);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', next);
  }

  @override
  Widget build(BuildContext context) {
    final isAr = _lang == 'ar';
    return MaterialApp(
      title: isAr ? 'كاشف أمراض التفاح' : 'Détecteur Maladies Pommier',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: HomeScreen(
        classifier: widget.classifier,
        lang: _lang,
        onToggleLang: _toggleLang,
      ),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2E7D32), // vert pommier
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(64), // grands boutons
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
