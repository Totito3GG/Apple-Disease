// Données complètes des 4 maladies — français + arabe
// Clés = noms exacts retournés par class_names.json

class DiseaseInfo {
  final String nameFr;
  final String nameAr;
  final String emoji;
  final String descFr;
  final String descAr;
  final List<String> symptomesFr;
  final List<String> symptomesAr;
  final List<String> traitementsFr;
  final List<String> traitementsAr;
  final bool isHealthy;

  const DiseaseInfo({
    required this.nameFr,
    required this.nameAr,
    required this.emoji,
    required this.descFr,
    required this.descAr,
    required this.symptomesFr,
    required this.symptomesAr,
    required this.traitementsFr,
    required this.traitementsAr,
    this.isHealthy = false,
  });
}

const Map<String, DiseaseInfo> kDiseaseData = {
  'Apple___Apple_scab': DiseaseInfo(
    nameFr: 'Tavelure du pommier',
    nameAr: 'جرب التفاح',
    emoji: '🍂',
    descFr: 'Maladie fongique causée par Venturia inaequalis. '
        'Très commune dans les régions humides.',
    descAr: 'مرض فطري ناجم عن فطر Venturia inaequalis. '
        'شائع جداً في المناطق الرطبة.',
    symptomesFr: [
      'Taches olive à brunes sur les feuilles',
      'Lésions liégeuses sur les fruits',
      'Déformation et chute prématurée des fruits',
      'Taches veloutées en début de saison',
    ],
    symptomesAr: [
      'بقع زيتونية إلى بنية على الأوراق',
      'آفات فلينية على الثمار',
      'تشوه وسقوط مبكر للثمار',
      'بقع مخملية في بداية الموسم',
    ],
    traitementsFr: [
      'Fongicide à base de captane ou de myclobutanil',
      'Traitement préventif dès le gonflement des bourgeons',
      'Ramasser et brûler les feuilles mortes en automne',
      'Élaguer pour améliorer la circulation de l'air',
      'Traitement curatif si détecté tôt (< 72h après infection)',
    ],
    traitementsAr: [
      'مبيد فطري على أساس الكابتان أو الميكلوبوتانيل',
      'علاج وقائي منذ تورم البراعم',
      'جمع وحرق الأوراق الميتة في الخريف',
      'التقليم لتحسين دوران الهواء',
      'علاج علاجي إذا اكتُشف مبكراً (< 72 ساعة بعد الإصابة)',
    ],
  ),

  'Apple___Black_rot': DiseaseInfo(
    nameFr: 'Pourriture noire',
    nameAr: 'العفن الأسود',
    emoji: '⚫',
    descFr: 'Champignon Botryosphaeria obtusa. Attaque les fruits, '
        'les branches et les feuilles.',
    descAr: 'فطر Botryosphaeria obtusa. يهاجم الثمار والأغصان والأوراق.',
    symptomesFr: [
      'Taches circulaires pourpres sur les feuilles',
      'Fruits qui noircissent et se rident',
      'Chancres sur les branches (plaies sombres)',
      'Petits points noirs (pycnides) visibles',
    ],
    symptomesAr: [
      'بقع دائرية بنفسجية على الأوراق',
      'اسوداد وتجعد الثمار',
      'قرح على الأغصان (جروح داكنة)',
      'نقاط سوداء صغيرة (بكنيديات) مرئية',
    ],
    traitementsFr: [
      'Tailler et brûler les branches infectées immédiatement',
      'Fongicide : captane, thirame ou myclobutanil',
      'Appliquer de la pâte cicatrisante sur les coupes',
      'Éviter les blessures lors de la taille (porte d'entrée)',
      'Traiter pendant la floraison et après la chute des pétales',
    ],
    traitementsAr: [
      'تقليم وحرق الأغصان المصابة فوراً',
      'مبيد فطري: الكابتان أو الثيرام أو الميكلوبوتانيل',
      'تطبيق معجون الشفاء على القطوع',
      'تجنب الجروح أثناء التقليم (نقطة دخول الفطر)',
      'العلاج خلال الإزهار وبعد سقوط البتلات',
    ],
  ),

  'Apple___Cedar_apple_rust': DiseaseInfo(
    nameFr: 'Rouille du pommier',
    nameAr: 'صدأ التفاح',
    emoji: '🟠',
    descFr: 'Champignon Gymnosporangium juniperi-virginianae. '
        'Nécessite deux hôtes : le pommier et le genévrier.',
    descAr: 'فطر Gymnosporangium juniperi-virginianae. '
        'يحتاج مضيفَين: شجرة التفاح والعرعر.',
    symptomesFr: [
      'Taches orange vif sur les feuilles (dessus)',
      'Tubes orange sous les feuilles (spores)',
      'Lésions jaune-orange sur les fruits',
      'Défoliation prématurée en cas d'attaque sévère',
    ],
    symptomesAr: [
      'بقع برتقالية زاهية على الأوراق (الجانب العلوي)',
      'أنابيب برتقالية أسفل الأوراق (جراثيم)',
      'آفات صفراء-برتقالية على الثمار',
      'تساقط مبكر للأوراق عند الإصابة الشديدة',
    ],
    traitementsFr: [
      'Myclobutanil ou propiconazole dès l'apparition des taches',
      'Traitement préventif au débourrement si historique de maladie',
      'Éliminer les genévriers proches si possible (hôte alternatif)',
      'Choisir des variétés résistantes pour les nouvelles plantations',
      '3 à 4 traitements espacés de 7-10 jours au printemps',
    ],
    traitementsAr: [
      'ميكلوبوتانيل أو بروبيكونازول عند ظهور البقع',
      'علاج وقائي عند انكسار الجفاف إذا كانت هناك سوابق للمرض',
      'إزالة العرعر المجاور إن أمكن (المضيف البديل)',
      'اختيار أصناف مقاومة للزراعات الجديدة',
      '3-4 علاجات بفاصل 7-10 أيام في الربيع',
    ],
  ),

  'Apple___healthy': DiseaseInfo(
    nameFr: 'Pommier sain',
    nameAr: 'شجرة تفاح صحية',
    emoji: '✅',
    descFr: 'Aucune maladie détectée. L'arbre semble en bonne santé.',
    descAr: 'لم يُكتشف أي مرض. تبدو الشجرة بصحة جيدة.',
    symptomesFr: ['Feuilles vertes et uniformes', 'Pas de taches visibles'],
    symptomesAr: ['أوراق خضراء ومتجانسة', 'لا توجد بقع مرئية'],
    traitementsFr: [
      'Continuer à surveiller régulièrement',
      'Arrosage adapté et taille annuelle',
      'Traitement préventif en début de saison si zone à risque',
    ],
    traitementsAr: [
      'الاستمرار في المراقبة المنتظمة',
      'ري مناسب وتقليم سنوي',
      'علاج وقائي في بداية الموسم إذا كانت المنطقة عرضة للخطر',
    ],
    isHealthy: true,
  ),
};
