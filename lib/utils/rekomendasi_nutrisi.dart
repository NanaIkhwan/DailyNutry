import 'package:flutter/material.dart';

class NutritionRecommendation {
  final String message;
  final Color color;
  final IconData icon;

  NutritionRecommendation({
    required this.message,
    required this.color,
    required this.icon,
  });
}

NutritionRecommendation? getNutritionRecommendation({
  required String type,
  required double current,
  required double max,
}) {
  final percent = current / max;

  if (percent < 0.6) return null;

  if (percent < 0.9) {
    switch (type) {
      case 'gula':
        return NutritionRecommendation(
          message: "Asupan gula mendekati batas harian. Kurangi minuman manis.",
          color: Colors.orange,
          icon: Icons.warning_amber_rounded,
        );
      case 'garam':
        return NutritionRecommendation(
          message: "Asupan garam hampir berlebih. Batasi makanan asin.",
          color: Colors.orange,
          icon: Icons.warning_amber_rounded,
        );
      case 'lemak':
        return NutritionRecommendation(
          message: "Asupan lemak cukup tinggi hari ini.",
          color: Colors.orange,
          icon: Icons.warning_amber_rounded,
        );
    }
  }

  switch (type) {
    case 'gula':
      return NutritionRecommendation(
        message: "Asupan gula sudah berlebih. Hindari minuman manis & dessert.",
        color: Colors.red,
        icon: Icons.error_outline,
      );
    case 'garam':
      return NutritionRecommendation(
        message: "Garam sudah melewati batas aman. Hindari makanan instan.",
        color: Colors.red,
        icon: Icons.error_outline,
      );
    case 'lemak':
      return NutritionRecommendation(
        message: "Lemak berlebih hari ini. Pilih makanan rebus/panggang.",
        color: Colors.red,
        icon: Icons.error_outline,
      );
  }

  return null;
}