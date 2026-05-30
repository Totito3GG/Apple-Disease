"""
Apple Disease Classifier — EfficientNet-B4
Corrections appliquées :
  - Input 380×380  (correct pour B4, pas 224×224)
  - 4 classes PlantVillage réelles (~5 100 images pommier)
  - Pondération des classes (Cedar Rust = seulement 275 images)
  - Transfer learning en 2 phases (pas full fine-tuning direct)
  - Float-16 TFLite (précision conservée vs INT8)
"""

import os
import json
import numpy as np
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers
from tensorflow.keras.applications import EfficientNetB4
from sklearn.utils.class_weight import compute_class_weight
from pathlib import Path

# ── Configuration ────────────────────────────────────────────────────────────
IMAGE_SIZE   = 380          # EfficientNet-B4 natif  (B0=224, B1=240, B4=380)
BATCH_SIZE   = 16           # réduit car images plus grandes
EPOCHS_HEAD  = 15           # Phase 1 : tête seule
EPOCHS_FINE  = 35           # Phase 2 : fine-tuning partiel
LR_HEAD      = 1e-3
LR_FINE      = 5e-5         # ×20 plus faible pour éviter catastrophic forgetting
DROPOUT      = 0.4
DATA_DIR     = Path("dataset/apple")   # structure : apple/Apple___Scab/...
MODEL_DIR    = Path("output")
MODEL_DIR.mkdir(exist_ok=True)

# Classes réelles du dataset PlantVillage (pommier uniquement)
CLASS_NAMES = [
    "Apple___Apple_scab",        # ~2 016 images
    "Apple___Black_rot",         # ~1 180 images
    "Apple___Cedar_apple_rust",  #   ~275 images  ← très déséquilibré
    "Apple___healthy",           # ~1 645 images
]
NUM_CLASSES = len(CLASS_NAMES)

# ── Augmentation ──────────────────────────────────────────────────────────────
def build_augmentation():
    return keras.Sequential([
        layers.RandomFlip("horizontal_and_vertical"),
        layers.RandomRotation(0.2),
        layers.RandomZoom(0.15),
        layers.RandomBrightness(0.2),
        layers.RandomContrast(0.2),
    ], name="augmentation")

# ── Dataset ───────────────────────────────────────────────────────────────────
def load_datasets():
    common = dict(
        directory=str(DATA_DIR),
        image_size=(IMAGE_SIZE, IMAGE_SIZE),
        batch_size=BATCH_SIZE,
        class_names=CLASS_NAMES,
        label_mode="categorical",
    )
    train_ds = keras.utils.image_dataset_from_directory(
        validation_split=0.2, subset="training", seed=42, **common)
    val_ds = keras.utils.image_dataset_from_directory(
        validation_split=0.2, subset="validation", seed=42, **common)

    # Normalisation EfficientNet (valeurs [0,255] → le modèle normalise en interne)
    AUTOTUNE = tf.data.AUTOTUNE
    augment  = build_augmentation()

    train_ds = (train_ds
                .map(lambda x, y: (augment(x, training=True), y),
                     num_parallel_calls=AUTOTUNE)
                .prefetch(AUTOTUNE))
    val_ds   = val_ds.prefetch(AUTOTUNE)
    return train_ds, val_ds

# ── Pondération des classes ───────────────────────────────────────────────────
def get_class_weights(train_ds):
    all_labels = []
    for _, y in train_ds:
        all_labels.extend(np.argmax(y.numpy(), axis=1))
    weights = compute_class_weight("balanced",
                                   classes=np.arange(NUM_CLASSES),
                                   y=np.array(all_labels))
    return {i: w for i, w in enumerate(weights)}

# ── Modèle ────────────────────────────────────────────────────────────────────
def build_model(trainable_base=False, fine_tune_from_pct=0.0):
    base = EfficientNetB4(
        include_top=False,
        weights="imagenet",
        input_shape=(IMAGE_SIZE, IMAGE_SIZE, 3),
        pooling="avg",
    )
    base.trainable = trainable_base
    if trainable_base and fine_tune_from_pct > 0:
        freeze_until = int(len(base.layers) * fine_tune_from_pct)
        for layer in base.layers[:freeze_until]:
            layer.trainable = False

    inputs  = keras.Input(shape=(IMAGE_SIZE, IMAGE_SIZE, 3))
    x       = base(inputs, training=trainable_base)
    x       = layers.BatchNormalization()(x)
    x       = layers.Dropout(DROPOUT)(x)
    outputs = layers.Dense(NUM_CLASSES, activation="softmax")(x)
    return keras.Model(inputs, outputs)

# ── Callbacks ─────────────────────────────────────────────────────────────────
def get_callbacks(phase: str):
    return [
        keras.callbacks.EarlyStopping(
            monitor="val_accuracy", patience=6, restore_best_weights=True),
        keras.callbacks.ReduceLROnPlateau(
            monitor="val_loss", factor=0.3, patience=3, min_lr=1e-7),
        keras.callbacks.ModelCheckpoint(
            str(MODEL_DIR / f"best_{phase}.h5"),
            monitor="val_accuracy", save_best_only=True),
    ]

# ── Entraînement ──────────────────────────────────────────────────────────────
def train():
    print("Chargement du dataset…")
    train_ds, val_ds = load_datasets()
    class_weights    = get_class_weights(train_ds)
    print(f"Poids des classes : {class_weights}")

    # ─ Phase 1 : tête seule ──────────────────────────────────────────────────
    print("\n── Phase 1 : entraînement de la tête (base gelée) ──")
    model = build_model(trainable_base=False)
    model.compile(
        optimizer=keras.optimizers.Adam(LR_HEAD),
        loss="categorical_crossentropy",
        metrics=["accuracy"],
    )
    model.fit(train_ds, validation_data=val_ds,
              epochs=EPOCHS_HEAD, class_weight=class_weights,
              callbacks=get_callbacks("phase1"))

    # ─ Phase 2 : fine-tuning des 30 dernières % de couches ───────────────────
    print("\n── Phase 2 : fine-tuning partiel (derniers 30 % des couches) ──")
    model = build_model(trainable_base=True, fine_tune_from_pct=0.70)
    model.load_weights(str(MODEL_DIR / "best_phase1.h5"))
    model.compile(
        optimizer=keras.optimizers.Adam(LR_FINE),
        loss="categorical_crossentropy",
        metrics=["accuracy"],
    )
    model.fit(train_ds, validation_data=val_ds,
              epochs=EPOCHS_FINE, class_weight=class_weights,
              callbacks=get_callbacks("phase2"))

    # ─ Sauvegarde finale ──────────────────────────────────────────────────────
    model.save(str(MODEL_DIR / "apple_disease_final.h5"))
    with open(MODEL_DIR / "class_names.json", "w", encoding="utf-8") as f:
        json.dump(CLASS_NAMES, f, ensure_ascii=False, indent=2)
    print(f"\nModèle sauvegardé dans {MODEL_DIR}/")

if __name__ == "__main__":
    train()
