import 'package:flutter/material.dart';
import '../models/disease_data.dart';

class GuideScreen extends StatelessWidget {
  final String lang;
  final VoidCallback onToggleLang;

  const GuideScreen({
    super.key,
    required this.lang,
    required this.onToggleLang,
  });

  bool get _isAr => lang == 'ar';
  String _t(String fr, String ar) => _isAr ? ar : fr;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final diseases = kDiseaseData.entries.toList();

    return Directionality(
      textDirection: _isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: cs.primary,
          foregroundColor: Colors.white,
          title: Text(_t('📖 Guide des maladies', '📖 دليل الأمراض'),
              style: const TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            TextButton(
              onPressed: onToggleLang,
              child: Text(_isAr ? 'FR' : 'ع',
                  style: const TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: diseases.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final d = diseases[i].value;
            return _DiseaseCard(disease: d, isAr: _isAr, t: _t);
          },
        ),
      ),
    );
  }
}

class _DiseaseCard extends StatefulWidget {
  final DiseaseInfo disease;
  final bool isAr;
  final String Function(String fr, String ar) t;

  const _DiseaseCard({
    required this.disease,
    required this.isAr,
    required this.t,
  });

  @override
  State<_DiseaseCard> createState() => _DiseaseCardState();
}

class _DiseaseCardState extends State<_DiseaseCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final d  = widget.disease;
    final ok = d.isHealthy;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête
              Row(
                children: [
                  Text(d.emoji, style: const TextStyle(fontSize: 36)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.isAr ? d.nameAr : d.nameFr,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Icon(_expanded
                      ? Icons.expand_less
                      : Icons.expand_more),
                ],
              ),

              if (_expanded) ...[
                const SizedBox(height: 12),
                Text(
                  widget.isAr ? d.descAr : d.descFr,
                  style: const TextStyle(fontSize: 14, height: 1.6),
                ),

                if (!ok) ...[
                  const SizedBox(height: 12),
                  Text(
                    widget.t('Symptômes :', 'الأعراض:'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  ...(widget.isAr ? d.symptomesAr : d.symptomesFr).map(
                    (s) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text('• $s',
                          style: const TextStyle(fontSize: 14)),
                    ),
                  ),
                ],

                const SizedBox(height: 12),
                Text(
                  widget.t('Traitements :', 'العلاجات:'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                ...(widget.isAr ? d.traitementsAr : d.traitementsFr)
                    .asMap()
                    .entries
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            '${e.key + 1}. ${e.value}',
                            style: TextStyle(
                              fontSize: 14,
                              color: ok
                                  ? Colors.green.shade800
                                  : Colors.orange.shade800,
                            ),
                          ),
                        )),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
