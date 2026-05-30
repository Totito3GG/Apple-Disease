// Données complètes des 6 maladies — français + arabe
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
  'Apple_scab': DiseaseInfo(
    nameFr: 'Tavelure du pommier',
    nameAr: 'جرب التفاح',
    emoji: '🍂',
    descFr: 'Maladie fongique causee par Venturia inaequalis. '
        'Tres commune dans les regions humides.',
    descAr: 'مرض فطري ناجم عن فطر Venturia inaequalis. '
        'شائع جداً في المناطق الرطبة.',
    symptomesFr: [
      'Taches olive a brunes sur les feuilles',
      'Lesions liegeuses sur les fruits',
      'Deformation et chute prematuree des fruits',
      'Taches veloutees en debut de saison',
    ],
    symptomesAr: [
      'بقع زيتونية إلى بنية على الأوراق',
      'آفات فلينية على الثمار',
      'تشوه وسقوط مبكر للثمار',
      'بقع مخملية في بداية الموسم',
    ],
    traitementsFr: [
      'Fongicide a base de captane ou de myclobutanil',
      'Traitement preventif des le gonflement des bourgeons',
      'Ramasser et bruler les feuilles mortes en automne',
      "Elaguer pour ameliorer la circulation de l'air",
      'Traitement curatif si detecte tot (moins de 72h apres infection)',
    ],
    traitementsAr: [
      'مبيد فطري على أساس الكابتان أو الميكلوبوتانيل',
      'علاج وقائي منذ تورم البراعم',
      'جمع وحرق الأوراق الميتة في الخريف',
      'التقليم لتحسين دوران الهواء',
      'علاج علاجي إذا اكتُشف مبكراً (أقل من 72 ساعة بعد الإصابة)',
    ],
  ),

  'Black_rot': DiseaseInfo(
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
      'Tailler et bruler les branches infectees immediatement',
      'Fongicide : captane, thirame ou myclobutanil',
      'Appliquer de la pate cicatrisante sur les coupes',
      "Eviter les blessures lors de la taille (porte d'entree)",
      'Traiter pendant la floraison et apres la chute des petales',
    ],
    traitementsAr: [
      'تقليم وحرق الأغصان المصابة فوراً',
      'مبيد فطري: الكابتان أو الثيرام أو الميكلوبوتانيل',
      'تطبيق معجون الشفاء على القطوع',
      'تجنب الجروح أثناء التقليم (نقطة دخول الفطر)',
      'العلاج خلال الإزهار وبعد سقوط البتلات',
    ],
  ),

  'Cedar_apple_rust': DiseaseInfo(
    nameFr: 'Rouille du pommier',
    nameAr: 'صدأ التفاح',
    emoji: '🟠',
    descFr: 'Champignon Gymnosporangium juniperi-virginianae. '
        'Necessite deux hotes : le pommier et le genevrier.',
    descAr: 'فطر Gymnosporangium juniperi-virginianae. '
        'يحتاج مضيفَين: شجرة التفاح والعرعر.',
    symptomesFr: [
      'Taches orange vif sur les feuilles (dessus)',
      'Tubes orange sous les feuilles (spores)',
      'Lesions jaune-orange sur les fruits',
      "Defoliation prematuree en cas d'attaque severe",
    ],
    symptomesAr: [
      'بقع برتقالية زاهية على الأوراق (الجانب العلوي)',
      'أنابيب برتقالية أسفل الأوراق (جراثيم)',
      'آفات صفراء-برتقالية على الثمار',
      'تساقط مبكر للأوراق عند الإصابة الشديدة',
    ],
    traitementsFr: [
      "Myclobutanil ou propiconazole des l'apparition des taches",
      'Traitement preventif au debourrement si historique de maladie',
      'Eliminer les genevriers proches si possible (hote alternatif)',
      'Choisir des varietes resistantes pour les nouvelles plantations',
      '3 a 4 traitements espaces de 7-10 jours au printemps',
    ],
    traitementsAr: [
      'ميكلوبوتانيل أو بروبيكونازول عند ظهور البقع',
      'علاج وقائي عند انكسار الجفاف إذا كانت هناك سوابق للمرض',
      'إزالة العرعر المجاور إن أمكن (المضيف البديل)',
      'اختيار أصناف مقاومة للزراعات الجديدة',
      '3-4 علاجات بفاصل 7-10 أيام في الربيع',
    ],
  ),

  'Altenaria_Leaf_Spot': DiseaseInfo(
    nameFr: 'Tache alternaria',
    nameAr: 'تبقع الترناريا',
    emoji: '🟤',
    descFr: 'Champignon Alternaria mali. Provoque des taches brunes '
        'sur les feuilles, surtout en periode chaude et humide.',
    descAr: 'فطر Alternaria mali. يسبب بقعاً بنية على الأوراق، '
        'خاصة في الفترات الحارة والرطبة.',
    symptomesFr: [
      'Taches circulaires brun fonce avec halo jaune',
      'Centre des taches qui tombe (aspect troue)',
      'Feuilles jaunissent et tombent prematurement',
      'Attaque surtout les feuilles agees',
    ],
    symptomesAr: [
      'بقع دائرية بنية داكنة مع هالة صفراء',
      'مركز البقع يسقط (مظهر مثقوب)',
      'اصفرار وسقوط مبكر للأوراق',
      'تصيب أساساً الأوراق العجوز',
    ],
    traitementsFr: [
      'Fongicide a base de mancozebbe ou de captane',
      "Traitement des l'apparition des premieres taches",
      'Ramasser et detruire les feuilles tombees',
      "Eviter l'irrigation par aspersion (favorise le champignon)",
      'Bonne ventilation par taille reguliere',
    ],
    traitementsAr: [
      'مبيد فطري على أساس المانكوزيب أو الكابتان',
      'العلاج فور ظهور أولى البقع',
      'جمع وإتلاف الأوراق المتساقطة',
      'تجنب الري بالرش (يشجع الفطر)',
      'تهوية جيدة عن طريق التقليم المنتظم',
    ],
  ),

  'Powdery_Mildew': DiseaseInfo(
    nameFr: 'Oidium du pommier',
    nameAr: 'البياض الدقيقي',
    emoji: '⬜',
    descFr: 'Champignon Podosphaera leucotricha. Forme un feutrage '
        'blanc caracteristique sur les feuilles et les jeunes pousses.',
    descAr: 'فطر Podosphaera leucotricha. يكوّن طبقة بيضاء مميزة '
        'على الأوراق والبراعم الصغيرة.',
    symptomesFr: [
      'Poudre blanche farineuse sur les feuilles',
      'Feuilles enroulees et deformees',
      'Jeunes pousses couvertes de blanc',
      'Fruits avec taches liegeuses rugueuses',
      'Croissance ralentie des rameaux atteints',
    ],
    symptomesAr: [
      'مسحوق أبيض دقيقي على الأوراق',
      'تجعد وتشوه الأوراق',
      'البراعم الصغيرة مغطاة بالأبيض',
      'بقع فلينية خشنة على الثمار',
      'تباطؤ نمو الأفرع المصابة',
    ],
    traitementsFr: [
      'Soufre mouillable en preventif des le debourrement',
      'Myclobutanil ou tebuconazole en curatif',
      'Tailler et bruler les rameaux atteints en hiver',
      "Eviter les exces d'azote (favorise les pousses tendres)",
      'Traiter toutes les 10-14 jours en periode a risque',
    ],
    traitementsAr: [
      'الكبريت القابل للبلل وقائياً منذ بداية تفتح البراعم',
      'ميكلوبوتانيل أو تيبوكونازول علاجياً',
      'تقليم وحرق الأفرع المصابة في الشتاء',
      'تجنب الإفراط في الآزوت (يشجع النمو الطري)',
      'العلاج كل 10-14 يوماً في فترة الخطر',
    ],
  ),

  'Healthy': DiseaseInfo(
    nameFr: 'Pommier sain',
    nameAr: 'شجرة تفاح صحية',
    emoji: '✅',
    descFr: "Aucune maladie detectee. L'arbre semble en bonne sante.",
    descAr: 'لم يُكتشف أي مرض. تبدو الشجرة بصحة جيدة.',
    symptomesFr: ['Feuilles vertes et uniformes', 'Pas de taches visibles'],
    symptomesAr: ['أوراق خضراء ومتجانسة', 'لا توجد بقع مرئية'],
    traitementsFr: [
      'Continuer a surveiller regulierement',
      'Arrosage adapte et taille annuelle',
      'Traitement preventif en debut de saison si zone a risque',
    ],
    traitementsAr: [
      'الاستمرار في المراقبة المنتظمة',
      'ري مناسب وتقليم سنوي',
      'علاج وقائي في بداية الموسم إذا كانت المنطقة عرضة للخطر',
    ],
    isHealthy: true,
  ),

  'Apple___healthy': DiseaseInfo(
    nameFr: 'Pommier sain',
    nameAr: 'شجرة تفاح صحية',
    emoji: '✅',
    descFr: "Aucune maladie detectee. L'arbre semble en bonne sante.",
    descAr: 'لم يُكتشف أي مرض. تبدو الشجرة بصحة جيدة.',
    symptomesFr: ['Feuilles vertes et uniformes', 'Pas de taches visibles'],
    symptomesAr: ['أوراق خضراء ومتجانسة', 'لا توجد بقع مرئية'],
    traitementsFr: [
      'Continuer a surveiller regulierement',
      'Arrosage adapte et taille annuelle',
      'Traitement preventif en debut de saison si zone a risque',
    ],
    traitementsAr: [
      'الاستمرار في المراقبة المنتظمة',
      'ري مناسب وتقليم سنوي',
      'علاج وقائي في بداية الموسم إذا كانت المنطقة عرضة للخطر',
    ],
    isHealthy: true,
  ),
};
