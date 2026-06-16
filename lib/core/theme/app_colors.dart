import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF070B14);
  static const Color primaryGreen = Color(0xFF1FC39F);
  
  static const Color rankElite = Color(0xFFF6A035);
  static const Color rankAdvanced = Color(0xFF2462C2);
  static const Color rankIntermediate = Color(0xFF1FC39F);
  static const Color rankBeginner = Color(0xFFE5E7EB);
  
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0x66FFFFFF);
  static const Color textMuted = Color(0x4DFFFFFF);
  static const Color textAccent = Color(0x99FFFFFF);
  
  static const Color cardBackground = Color(0xFF151923);
  static const Color divider = Color(0x1AFFFFFF);

  static Color getRankColor(String level) {
    switch (level) {
      case 'Elite':
        return rankElite;
      case 'Advanced':
        return rankAdvanced;
      case 'Intermediate':
        return rankIntermediate;
      case 'Beginner':
      default:
        return rankBeginner;
    }
  }
}
