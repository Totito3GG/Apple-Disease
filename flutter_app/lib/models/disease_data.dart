// Données des 6 maladies — français + arabe
// Inclut : produits, dosages, mode d'emploi pour exploitation de 900 arbres

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

  // ─── 1. TAVELURE ──────────────────────────────────────────────────────────
  'Apple_scab': DiseaseInfo(
    nameFr: 'Tavelure du pommier',
    nameAr: 'جرب التفاح',
    emoji: '🍂',
    descFr: 'Maladie fongique causee par Venturia inaequalis. '
        'Tres repandue dans les vergers humides.',
    descAr: 'مرض فطري ناجم عن فطر Venturia inaequalis. '
        'شائع جداً في البساتين الرطبة.',
    symptomesFr: [
      'Taches olive a brunes sur les feuilles',
      'Lesions liegeuses et craquelees sur les fruits',
      'Chute prematuree des feuilles et fruits',
    ],
    symptomesAr: [
      'بقع زيتونية إلى بنية على الأوراق',
      'آفات فلينية ومتشققة على الثمار',
      'تساقط مبكر للأوراق والثمار',
    ],
    traitementsFr: [
      'PRODUIT 1 — Captane 50 WP (Captan)\n'
      '   Dose : 2 g par litre d\'eau\n'
      '   Pour 900 arbres : 3 a 4 kg par traitement\n'
      '   Quand : des le gonflement des bourgeons, tous les 7-10 jours\n'
      '   Comment : pulveriser jusqu\'a ruissellement sur feuilles et fruits\n'
      '   Nb traitements : 4 a 6 par saison',

      'PRODUIT 2 — Myclobutanil (Systhane 20 EW)\n'
      '   Dose : 0,5 mL par litre d\'eau\n'
      '   Pour 900 arbres : 0,8 L par traitement\n'
      '   Quand : des les premieres taches (curatif, sous 72h)\n'
      '   Avantage : systemique, agit de l\'interieur de la plante\n'
      '   Nb traitements : 2 a 3 max (risque resistance)',

      'CONSEIL PRATIQUE :\n'
      '   Alterner Captane et Myclobutanil pour eviter la resistance\n'
      '   Ne pas traiter si pluie prevue dans les 2h\n'
      '   Volume d\'eau recommande : 500 a 800 L/ha',
    ],
    traitementsAr: [
      'المنتج 1 — كابتان 50 WP\n'
      '   الجرعة: 2 غ لكل لتر ماء\n'
      '   لـ 900 شجرة: 3 إلى 4 كغ لكل رشة\n'
      '   التوقيت: منذ انتفاخ البراعم، كل 7-10 أيام\n'
      '   الطريقة: الرش حتى التقطير على الأوراق والثمار\n'
      '   عدد المعالجات: 4 إلى 6 في الموسم',

      'المنتج 2 — ميكلوبوتانيل (سيسثان 20 EW)\n'
      '   الجرعة: 0.5 مل لكل لتر ماء\n'
      '   لـ 900 شجرة: 0.8 لتر لكل رشة\n'
      '   التوقيت: عند ظهور أولى البقع (علاجي، خلال 72 ساعة)\n'
      '   الميزة: جهازي، يعمل من داخل النبات\n'
      '   عدد المعالجات: 2 إلى 3 كحد أقصى',

      'نصيحة عملية:\n'
      '   تناوب بين الكابتان والميكلوبوتانيل لتجنب المقاومة\n'
      '   لا ترش إذا كان هناك مطر متوقع في الساعتين القادمتين\n'
      '   حجم الماء الموصى به: 500 إلى 800 لتر/هكتار',
    ],
  ),

  // ─── 2. POURRITURE NOIRE ──────────────────────────────────────────────────
  'Black_rot': DiseaseInfo(
    nameFr: 'Pourriture noire',
    nameAr: 'العفن الأسود',
    emoji: '⚫',
    descFr: 'Champignon Botryosphaeria obtusa. Attaque fruits, branches et feuilles.',
    descAr: 'فطر Botryosphaeria obtusa. يهاجم الثمار والأغصان والأوراق.',
    symptomesFr: [
      'Taches circulaires pourpres sur feuilles',
      'Fruits noircissent avec anneaux concentriques',
      'Chancres sombres et enfonces sur branches',
    ],
    symptomesAr: [
      'بقع دائرية بنفسجية على الأوراق',
      'اسوداد الثمار مع حلقات متحدة المركز',
      'قرح داكنة وغائرة على الأغصان',
    ],
    traitementsFr: [
      'ACTION IMMEDIATE — Taille sanitaire\n'
      '   Couper toutes branches malades 15 cm sous la lesion\n'
      '   Bruler les branches coupees (ne pas composter)\n'
      '   Desinfecter les outils avec alcool 70% entre chaque coupe',

      'PRODUIT 1 — Captane 50 WP\n'
      '   Dose : 2 g/L\n'
      '   Pour 900 arbres : 3 a 4 kg par traitement\n'
      '   Quand : floraison, chute des petales, et toutes les 2 semaines\n'
      '   Nb traitements : 3 a 5 par saison',

      'PRODUIT 2 — Thirame 70 WP (Thiram)\n'
      '   Dose : 3 g/L\n'
      '   Pour 900 arbres : 4 a 5 kg par traitement\n'
      '   Avantage : protege aussi contre la moniliose\n'
      '   ATTENTION : ne pas utiliser apres la floraison sur fruits',

      'CICATRISATION — Pate Bouille Bordelaise\n'
      '   Appliquer sur toutes les coupes de taille\n'
      '   Disponible en jardinerie, pret a l\'emploi',
    ],
    traitementsAr: [
      'إجراء فوري — التقليم الصحي\n'
      '   قطع جميع الأغصان المريضة 15 سم تحت الآفة\n'
      '   حرق الأغصان المقطوعة (لا تضعها في الكومبوست)\n'
      '   تعقيم الأدوات بالكحول 70% بين كل قطعة',

      'المنتج 1 — كابتان 50 WP\n'
      '   الجرعة: 2 غ/لتر\n'
      '   لـ 900 شجرة: 3 إلى 4 كغ لكل رشة\n'
      '   التوقيت: الإزهار، سقوط البتلات، كل أسبوعين\n'
      '   عدد المعالجات: 3 إلى 5 في الموسم',

      'المنتج 2 — ثيرام 70 WP\n'
      '   الجرعة: 3 غ/لتر\n'
      '   لـ 900 شجرة: 4 إلى 5 كغ لكل رشة\n'
      '   الميزة: يحمي أيضاً من العفن البني\n'
      '   تحذير: لا تستخدمه بعد الإزهار على الثمار',

      'التندئيب — معجون البوردو\n'
      '   ضعه على جميع قطوع التقليم\n'
      '   متوفر جاهزاً في متاجر الأدوية الزراعية',
    ],
  ),

  // ─── 3. ROUILLE ───────────────────────────────────────────────────────────
  'Cedar_apple_rust': DiseaseInfo(
    nameFr: 'Rouille du pommier',
    nameAr: 'صدأ التفاح',
    emoji: '🟠',
    descFr: 'Champignon Gymnosporangium. Cycle entre pommier et genevrier.',
    descAr: 'فطر Gymnosporangium. دورة حياته بين التفاح والعرعر.',
    symptomesFr: [
      'Taches orange vif sur feuilles (face superieure)',
      'Tubes orange sous les feuilles (spores)',
      'Lesions jaune-orange sur fruits',
    ],
    symptomesAr: [
      'بقع برتقالية زاهية على الأوراق (الوجه العلوي)',
      'أنابيب برتقالية أسفل الأوراق (الجراثيم)',
      'آفات صفراء-برتقالية على الثمار',
    ],
    traitementsFr: [
      'PRODUIT 1 — Myclobutanil (Systhane 20 EW)\n'
      '   Dose : 0,5 mL/L\n'
      '   Pour 900 arbres : 0,8 L par traitement\n'
      '   Quand : stade "bouton rose" jusqu\'a chute des petales\n'
      '   Rythme : tous les 10-14 jours\n'
      '   Nb traitements : 3 a 4 au printemps',

      'PRODUIT 2 — Propiconazole (Tilt 250 EC)\n'
      '   Dose : 0,5 mL/L\n'
      '   Pour 900 arbres : 0,8 L par traitement\n'
      '   Avantage : tres efficace en curatif (sous 48h apres infection)\n'
      '   Nb traitements : 2 max par saison',

      'PREVENTION LONGUE DUREE :\n'
      '   Arracher les genevriers dans un rayon de 500m si possible\n'
      '   (ils sont le seul hote hivernal du champignon)\n'
      '   Planter des varietes resistantes pour le renouvellement',
    ],
    traitementsAr: [
      'المنتج 1 — ميكلوبوتانيل (سيسثان 20 EW)\n'
      '   الجرعة: 0.5 مل/لتر\n'
      '   لـ 900 شجرة: 0.8 لتر لكل رشة\n'
      '   التوقيت: من مرحلة "البرعم الوردي" حتى سقوط البتلات\n'
      '   الإيقاع: كل 10-14 يوم\n'
      '   عدد المعالجات: 3 إلى 4 في الربيع',

      'المنتج 2 — بروبيكونازول (تيلت 250 EC)\n'
      '   الجرعة: 0.5 مل/لتر\n'
      '   لـ 900 شجرة: 0.8 لتر لكل رشة\n'
      '   الميزة: فعال جداً علاجياً (خلال 48 ساعة من الإصابة)\n'
      '   عدد المعالجات: 2 كحد أقصى في الموسم',

      'الوقاية طويلة الأمد:\n'
      '   اقتلاع أشجار العرعر في دائرة 500م إن أمكن\n'
      '   (هي المضيف الشتوي الوحيد للفطر)\n'
      '   زرع أصناف مقاومة عند تجديد البستان',
    ],
  ),

  // ─── 4. ALTERNARIA ────────────────────────────────────────────────────────
  'Altenaria_Leaf_Spot': DiseaseInfo(
    nameFr: 'Tache alternaria',
    nameAr: 'تبقع الترناريا',
    emoji: '🟤',
    descFr: 'Champignon Alternaria mali. Taches brunes surtout en ete chaud et humide.',
    descAr: 'فطر Alternaria mali. بقع بنية خاصة في الصيف الحار الرطب.',
    symptomesFr: [
      'Taches rondes brun fonce avec halo jaune',
      'Centre des taches qui se troue et tombe',
      'Feuilles jaunissent et tombent en masse',
    ],
    symptomesAr: [
      'بقع دائرية بنية داكنة مع هالة صفراء',
      'مركز البقع يصبح مثقوباً ويسقط',
      'اصفرار وتساقط جماعي للأوراق',
    ],
    traitementsFr: [
      'PRODUIT 1 — Mancozebe 80 WP (Mancozeb/Dithane)\n'
      '   Dose : 2 g/L\n'
      '   Pour 900 arbres : 3 a 4 kg par traitement\n'
      '   Quand : preventif des les premieres chaleurs (juin-juillet)\n'
      '   Rythme : tous les 10-14 jours\n'
      '   Nb traitements : 3 a 4',

      'PRODUIT 2 — Iprodione (Rovral 50 WP)\n'
      '   Dose : 1,5 g/L\n'
      '   Pour 900 arbres : 2 kg par traitement\n'
      '   Avantage : efficace curatif sur taches recentes\n'
      '   Nb traitements : 2 max (resistance possible)',

      'HYGIENE DU VERGER :\n'
      '   Ramasser toutes les feuilles tombees (source de spores)\n'
      '   Bruler ou enfouir profondement a l\'automne\n'
      '   Eviter irrigation par aspersion le soir',
    ],
    traitementsAr: [
      'المنتج 1 — مانكوزيب 80 WP (دايثان)\n'
      '   الجرعة: 2 غ/لتر\n'
      '   لـ 900 شجرة: 3 إلى 4 كغ لكل رشة\n'
      '   التوقيت: وقائي منذ بداية الحر (يونيو-يوليوز)\n'
      '   الإيقاع: كل 10-14 يوم\n'
      '   عدد المعالجات: 3 إلى 4',

      'المنتج 2 — إيبروديون (روفرال 50 WP)\n'
      '   الجرعة: 1.5 غ/لتر\n'
      '   لـ 900 شجرة: 2 كغ لكل رشة\n'
      '   الميزة: فعال علاجياً على البقع الحديثة\n'
      '   عدد المعالجات: 2 كحد أقصى',

      'نظافة البستان:\n'
      '   جمع جميع الأوراق المتساقطة (مصدر الجراثيم)\n'
      '   حرقها أو دفنها عميقاً في الخريف\n'
      '   تجنب الري بالرش مساءً',
    ],
  ),

  // ─── 5. OIDIUM ────────────────────────────────────────────────────────────
  'Powdery_Mildew': DiseaseInfo(
    nameFr: 'Oidium du pommier',
    nameAr: 'البياض الدقيقي',
    emoji: '⬜',
    descFr: 'Champignon Podosphaera leucotricha. Poudre blanche caracteristique.',
    descAr: 'فطر Podosphaera leucotricha. مسحوق أبيض مميز.',
    symptomesFr: [
      'Poudre blanche farineuse sur feuilles et pousses',
      'Feuilles enroulees et deformees',
      'Taches liegeruses rugueuses sur fruits',
    ],
    symptomesAr: [
      'مسحوق أبيض دقيقي على الأوراق والأفرع',
      'تجعد وتشوه الأوراق',
      'بقع فلينية خشنة على الثمار',
    ],
    traitementsFr: [
      'PRODUIT 1 — Soufre mouillable 80 WP\n'
      '   Dose : 3 g/L (preventif) / 5 g/L (curatif)\n'
      '   Pour 900 arbres : 5 a 8 kg par traitement\n'
      '   Quand : des le debourrement, toutes les 8-10 jours\n'
      '   IMPORTANT : ne pas utiliser si temperature > 30 degres C\n'
      '   (risque de brulures sur les feuilles)\n'
      '   Nb traitements : 6 a 8 par saison\n'
      '   Avantage : tres economique pour grande exploitation',

      'PRODUIT 2 — Myclobutanil (Systhane 20 EW)\n'
      '   Dose : 0,5 mL/L\n'
      '   Pour 900 arbres : 0,8 L par traitement\n'
      '   Quand : en alternance avec le soufre\n'
      '   Avantage : systemique, efficace par temps chaud',

      'TAILLE PREVENTIVE (novembre-fevrier) :\n'
      '   Couper et bruler tous les rameaux avec taches blanches\n'
      '   Ces rameaux malades hivernent et recontaminent au printemps\n'
      '   Reduire les apports d\'azote (favorise pousses tendres)',
    ],
    traitementsAr: [
      'المنتج 1 — كبريت قابل للبلل 80 WP\n'
      '   الجرعة: 3 غ/لتر (وقائي) / 5 غ/لتر (علاجي)\n'
      '   لـ 900 شجرة: 5 إلى 8 كغ لكل رشة\n'
      '   التوقيت: منذ انكسار البراعم، كل 8-10 أيام\n'
      '   مهم: لا تستخدمه إذا كانت الحرارة أعلى من 30 درجة\n'
      '   (خطر الحروق على الأوراق)\n'
      '   عدد المعالجات: 6 إلى 8 في الموسم\n'
      '   الميزة: اقتصادي جداً للبستان الكبير',

      'المنتج 2 — ميكلوبوتانيل (سيسثان 20 EW)\n'
      '   الجرعة: 0.5 مل/لتر\n'
      '   لـ 900 شجرة: 0.8 لتر لكل رشة\n'
      '   التوقيت: بالتناوب مع الكبريت\n'
      '   الميزة: جهازي، فعال في الطقس الحار',

      'التقليم الوقائي (نوفمبر-فبراير):\n'
      '   قطع وحرق جميع الأفرع ذات البقع البيضاء\n'
      '   هذه الأفرع تشتي المرض وتعيد العدوى في الربيع\n'
      '   تقليل إضافة الآزوت (يشجع النمو الطري)',
    ],
  ),

  // ─── 6. SAIN ─────────────────────────────────────────────────────────────
  'Healthy': DiseaseInfo(
    nameFr: 'Pommier sain',
    nameAr: 'شجرة تفاح صحية',
    emoji: '✅',
    descFr: "Aucune maladie detectee. L'arbre est en bonne sante.",
    descAr: 'لم يُكتشف أي مرض. الشجرة بصحة جيدة.',
    symptomesFr: ['Feuilles vertes et uniformes', 'Pas de taches visibles'],
    symptomesAr: ['أوراق خضراء ومتجانسة', 'لا توجد بقع مرئية'],
    traitementsFr: [
      'PROGRAMME DE PREVENTION (pour 900 arbres) :\n'
      '   Janvier-fevrier : taille sanitaire, bruler les bois malades\n'
      '   Mars (debourrement) : 1er traitement Captane preventif\n'
      '   Avril-mai : Captane + Soufre toutes les 10 jours\n'
      '   Juin-aout : Mancozebe ou Soufre si chaleur < 30 degres\n'
      '   Octobre : ramassage et destruction des feuilles tombees',

      'NUTRITION DES ARBRES :\n'
      '   Apport equilibre NPK en debut de saison\n'
      '   Eviter exces azote (favorise maladies fongiques)\n'
      '   Irrigation reguliere sans exces (evite stress hydrique)',

      'CONTINUER LA SURVEILLANCE :\n'
      '   Inspecter 5% des arbres par semaine (45 arbres)\n'
      '   Photographier et analyser avec cette application',
    ],
    traitementsAr: [
      'برنامج الوقاية (لـ 900 شجرة):\n'
      '   يناير-فبراير: تقليم صحي، حرق الأخشاب المريضة\n'
      '   مارس (انكسار البراعم): الرشة الأولى بالكابتان وقائياً\n'
      '   أبريل-مايو: كابتان + كبريت كل 10 أيام\n'
      '   يونيو-أغسطس: مانكوزيب أو كبريت إذا كانت الحرارة أقل من 30 درجة\n'
      '   أكتوبر: جمع وإتلاف الأوراق المتساقطة',

      'تغذية الأشجار:\n'
      '   إضافة متوازنة NPK في بداية الموسم\n'
      '   تجنب الإفراط في الآزوت (يشجع الأمراض الفطرية)\n'
      '   ري منتظم دون إفراط',

      'الاستمرار في المراقبة:\n'
      '   فحص 5% من الأشجار أسبوعياً (45 شجرة)\n'
      '   تصوير وتحليل باستخدام هذا التطبيق',
    ],
    isHealthy: true,
  ),

  // Clé de compatibilité avec ancien modele 4 classes
  'Apple___healthy': DiseaseInfo(
    nameFr: 'Pommier sain',
    nameAr: 'شجرة تفاح صحية',
    emoji: '✅',
    descFr: "Aucune maladie detectee. L'arbre est en bonne sante.",
    descAr: 'لم يُكتشف أي مرض. الشجرة بصحة جيدة.',
    symptomesFr: ['Feuilles vertes et uniformes', 'Pas de taches visibles'],
    symptomesAr: ['أوراق خضراء ومتجانسة', 'لا توجد بقع مرئية'],
    traitementsFr: ['Continuer la surveillance reguliere du verger'],
    traitementsAr: ['الاستمرار في المراقبة المنتظمة للبستان'],
    isHealthy: true,
  ),
};
