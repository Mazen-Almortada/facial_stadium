import 'package:facial_stadium/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle brandNameTextStyle({
    double? size,
  }) =>
      GoogleFonts.jotiOne(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size ?? 25,
        ),
      );
  static TextStyle primaryTextStyle(
          {Color? color, double? size, bool bold = false}) =>
      GoogleFonts.poppins(
          color: color,
          fontSize: size,
          fontWeight: bold ? FontWeight.bold : null);
  static TextStyle secondaryTextStyle(
          {Color? color, double? size, bool bold = false}) =>
      GoogleFonts.alfaSlabOne(
          color: color ?? AppColors.secondaryColor,
          fontSize: size,
          fontWeight: bold ? FontWeight.bold : null);
}
