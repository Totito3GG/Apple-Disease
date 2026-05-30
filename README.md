# Détecteur de maladies du pommier

## Corrections appliquées vs version précédente

| Problème | Avant | Après |
|----------|-------|-------|
| Taille input | 224×224 (EfficientNet-B0) | **380×380** (EfficientNet-B4 natif) |
| Nbre de classes | "10 maladies" | **4 classes réelles** PlantVillage |
| Nbre d'images | "38 000+" | **~5 100** (pommier uniquement) |
| Quantification | INT8 | **Float-16** (précision préservée) |
| Fine-tuning | Toutes les couches | **30% des couches** (évite l'oubli catastrophique) |
| Déséquilibre | Ignoré | **Pondération des classes** (Cedar Rust ×4-6) |

---

## Structure du projet

```
Apple/
├── training/
│   ├── Apple_Disease_Colab.ipynb   ← ouvrir dans Google Colab
│   ├── train.py                    ← si entraînement local
│   └── convert_tflite.py           ← conversion Float-16
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
        ├── apple_disease_f16.tflite  ← à générer (étape 2)
        └── class_names.json
```

---

## Étapes dans l'ordre

### 1. Entraîner sur Google Colab (gratuit, ~1h avec GPU T4)

1. Aller sur [colab.research.google.com](https://colab.research.google.com)
2. Uploader `training/Apple_Disease_Colab.ipynb`
3. `Runtime → Change runtime type → T4 GPU`
4. Exécuter toutes les cellules dans l'ordre
5. Télécharger `apple_disease_f16.tflite` + `class_names.json`

### 2. Copier le modèle dans Flutter

```
flutter_app/assets/model/apple_disease_f16.tflite   ← coller ici
flutter_app/assets/model/class_names.json            ← déjà présent
```

Mettre à jour `pubspec.yaml` si le nom du fichier change :
```yaml
assets:
  - assets/model/apple_disease_f16.tflite
```

### 3. Compiler l'APK Android

```bash
cd flutter_app
flutter pub get
flutter build apk --release
```

L'APK sera dans : `flutter_app/build/app/outputs/flutter-apk/app-release.apk`

### 4. Installer sur le téléphone

- Envoyer `app-release.apk` par WhatsApp ou USB
- Sur Android : `Paramètres → Sécurité → Sources inconnues → Activer`
- Ouvrir le fichier et installer

---

## Classes détectées

| Classe | Nom français | اسم بالعربية | ~Images |
|--------|-------------|--------------|---------|
| Apple___Apple_scab | Tavelure | جرب التفاح | 2 016 |
| Apple___Black_rot | Pourriture noire | العفن الأسود | 1 180 |
| Apple___Cedar_apple_rust | Rouille | صدأ التفاح | 275 |
| Apple___healthy | Sain | صحي | 1 645 |

> **Note Cedar Rust :** seulement 275 images → pondération ×4-6 appliquée automatiquement

---

## Précision attendue

- Phase 1 (tête seule) : ~88-92% val accuracy
- Phase 2 (fine-tuning 30%) : ~93-96% val accuracy
- Après conversion Float-16 : perte < 0.5%

La Cedar Rust est la classe la plus difficile (peu de données). Si la précision
sur cette classe est < 85%, augmenter son poids dans `class_weights` manuellement.
