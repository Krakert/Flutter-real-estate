import 'package:flutter/material.dart';
import 'package:flutter_real_estate/ui/theme/colors.dart';

// Setup of font types based on input from design theme
class AppTypography {
  static const title01 = TextStyle(
    fontFamily: "GothamSSm",
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.strong,
  );

  static const title02 = TextStyle(
    fontFamily: "GothamSSm",
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.strong,
  );

  static const title03 = TextStyle(
    fontFamily: "GothamSSm",
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.strong,
  );

  static const body = TextStyle(
    fontFamily: "GothamSSm",
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: AppColors.medium,
  );

  static const input = TextStyle(
    fontFamily: "GothamSSm",
    fontSize: 18,
    fontWeight: FontWeight.w300,
    color: AppColors.strong
  );

  static const hint = TextStyle(
    fontFamily: "GothamSSm",
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: AppColors.medium,
  );

  static const subtitle = TextStyle(
    fontFamily: "GothamSSm",
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: AppColors.strong,
  );

  static const detail = TextStyle(
    fontFamily: "GothamSSm",
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.medium,
  );
}
