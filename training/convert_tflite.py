"""
Conversion Keras → TFLite Float-16
Pourquoi Float-16 et pas INT8 :
  - INT8 nécessite un dataset de calibration et peut perdre 3-8% de précision
  - Float-16 : taille ÷2 (≈12 MB), précision quasi identique au modèle original
  - Sur Android/iOS modernes, Float-16 est accéléré matériellement (GPU delegate)
"""

import json
import numpy as np
import tensorflow as tf
from pathlib import Path

MODEL_H5   = Path("output/apple_disease_final.h5")
OUT_DIR    = Path("output")
TFLITE_F16 = OUT_DIR / "apple_disease_f16.tflite"
TFLITE_INT8 = OUT_DIR / "apple_disease_int8.tflite"   # généré aussi pour comparaison


def convert_float16():
    model     = tf.keras.models.load_model(str(MODEL_H5))
    converter = tf.lite.TFLiteConverter.from_keras_model(model)

    converter.optimizations          = [tf.lite.Optimize.DEFAULT]
    converter.target_spec.supported_types = [tf.float16]   # ← Float-16

    tflite_model = converter.convert()
    TFLITE_F16.write_bytes(tflite_model)
    size_mb = len(tflite_model) / 1_000_000
    print(f"Float-16 : {TFLITE_F16}  ({size_mb:.1f} MB)")
    return tflite_model


def convert_int8(representative_images: list):
    """INT8 avec dataset de représentation (200 images suffisent)."""
    model     = tf.keras.models.load_model(str(MODEL_H5))
    converter = tf.lite.TFLiteConverter.from_keras_model(model)

    converter.optimizations = [tf.lite.Optimize.DEFAULT]

    def representative_dataset():
        for img in representative_images[:200]:
            img = tf.image.resize(img, [380, 380])
            img = tf.expand_dims(img, 0)
            img = tf.cast(img, tf.float32)
            yield [img]

    converter.representative_dataset        = representative_dataset
    converter.target_spec.supported_ops     = [tf.lite.OpsSet.TFLITE_BUILTINS_INT8]
    converter.inference_input_type          = tf.uint8
    converter.inference_output_type         = tf.uint8

    tflite_model = converter.convert()
    TFLITE_INT8.write_bytes(tflite_model)
    size_mb = len(tflite_model) / 1_000_000
    print(f"INT8      : {TFLITE_INT8}  ({size_mb:.1f} MB)")


def benchmark_accuracy(tflite_path: Path, test_images, test_labels):
    """Vérifie la perte de précision après conversion."""
    interpreter = tf.lite.Interpreter(model_path=str(tflite_path))
    interpreter.allocate_tensors()

    inp  = interpreter.get_input_details()[0]
    out  = interpreter.get_output_details()[0]
    correct = 0

    for img, label in zip(test_images, test_labels):
        img = tf.image.resize(img, [380, 380])
        img = tf.expand_dims(img, 0)
        if inp["dtype"] == np.uint8:
            img = tf.cast(img, tf.uint8)
        else:
            img = tf.cast(img, tf.float32)
        interpreter.set_tensor(inp["index"], img.numpy())
        interpreter.invoke()
        pred = interpreter.get_tensor(out["index"])[0]
        if np.argmax(pred) == label:
            correct += 1

    acc = correct / len(test_labels) * 100
    print(f"  Précision {tflite_path.name}: {acc:.2f}%")
    return acc


if __name__ == "__main__":
    print("Conversion Float-16…")
    convert_float16()

    print("\nPour lancer la conversion INT8, appelle convert_int8(images) avec")
    print("200 images de validation chargées en numpy arrays (shape H×W×3, uint8).")

    print("\nConseillé : utiliser apple_disease_f16.tflite dans l'application Flutter.")
    print("Intégrer le fichier dans flutter_app/assets/model/")
