# Détecteur de maladies du pommier 🍎

## Résultats obtenus

| Métrique | Valeur |
|----------|--------|
| Modèle | EfficientNet-B4 |
| Classes | **6 maladies** |
| Images d'entraînement | **20 808** |
| Val accuracy | **100%** |
| Taille modèle TFLite | 35.2 MB (Float-16) |
| Plateforme | Android & iOS — 100% hors-ligne |

---

## Classes détectées

| Classe (code) | Français | العربية |
|---------------|----------|---------|
| `Apple_scab` | Tavelure | جرب التفاح |
| `Black_rot` | Pourriture noire | العفن الأسود |
| `Cedar_apple_rust` | Rouille | صدأ التفاح |
| `Altenaria_Leaf_Spot` | Tache alternaria | تبقع الترناريا |
| `Powdery_Mildew` | Oïdium | البياض الدقيقي |
| `Healthy` | Sain | صحي |

---

## Dataset utilisé

**PV-ALE** (PlantVillage Apple Leaves Extended) — version augmentée
- Source : `akinyemijoseph/apple-leaf-disease-dataset-6-classes-v2` sur Kaggle
- Dossier utilisé : `AppleLeafDisease/Aug_Set/`
- ~3 420–3 528 images par classe → dataset parfaitement équilibré
- Pas besoin de pondération des classes

---

## Architecture technique

```
Apple/
├── .github/
│   └── workflows/
│       └── build.yml              ← Build APK automatique via GitHub Actions
├── training/
│   ├── Apple_Disease_Colab.ipynb  ← Notebook Kaggle (entraînement)
│   ├── train.py                   ← Script local (optionnel)
│   └── convert_tflite.py          ← Conversion Float-16
└── flutter_app/
    ├── lib/
    │   ├── main.dart
    │   ├── screens/
    │   │   ├── home_screen.dart
    │   │   ├── result_screen.dart
    │   │   └── guide_screen.dart
    │   └── models/
    │       ├── classifier.dart
    │       └── disease_data.dart
    └── assets/model/
        ├── apple_disease_f16.tflite   ← modèle TFLite Float-16 (35.2 MB)
        └── class_names.json
```

---

## Choix techniques et pourquoi

| Décision | Choix | Raison |
|----------|-------|--------|
| Modèle | EfficientNet-B4 | Meilleur ratio précision/taille pour mobile |
| Input size | **380×380** | Taille native B4 (B0=224, B1=240, B4=380) |
| Quantification | **Float-16** | Taille ÷2, perte de précision < 0.5% (vs INT8 qui perd 3-8%) |
| Fine-tuning | **30% dernières couches** | Évite le catastrophic forgetting avec peu de données |
| Dataset | **PV-ALE Aug_Set** | 3 500+ images/classe vs 630 dans PlantVillage original |
| Build | **GitHub Actions** | Pas besoin d'installer Flutter localement |

---

## Entraînement (Kaggle)

1. Ouvrir un notebook sur **kaggle.com**
2. Ajouter le dataset : `akinyemijoseph/apple-leaf-disease-dataset-6-classes-v2`
3. Activer **GPU T4 x2** + **Internet ON** dans Session options
4. Coller et exécuter le code du notebook `training/Apple_Disease_Colab.ipynb`
5. Télécharger `apple_disease_6class_f16.tflite` et `class_names.json`
6. Renommer en `apple_disease_f16.tflite`
7. Copier dans `flutter_app/assets/model/`

**Durée totale :** ~90 minutes (Phase 1 : 30 min + Phase 2 : 60 min)

---

## Build APK via GitHub Actions

1. Pousser le code sur GitHub :
```bash
git add .
git commit -m "message"
git push
```
2. GitHub → onglet **Actions** → le build démarre automatiquement
3. Attendre ~5 minutes
4. Télécharger `apple-disease-detector-apk` dans les artefacts

---

## Installation sur Android

1. Envoyer `app-release.apk` par WhatsApp ou USB
2. `Paramètres → Sécurité → Sources inconnues → Activer`
3. Ouvrir le fichier APK et installer
4. L'app fonctionne **sans connexion internet**
