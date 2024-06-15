import 'package:facial_stadium/core/styles/app_text_style.dart';
import 'package:facial_stadium/core/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required this.onPressed,
      required this.text,
      this.textColor,
      this.buttonColors,
      super.key,
      this.margin,
      this.textSize,
      this.buttonHeight,
      this.buttonWidth});
  final void Function()? onPressed;

  final List<Color>? buttonColors;
  final String text;
  final Color? textColor;

  final EdgeInsetsGeometry? margin;
  final double? textSize;
  final double? buttonHeight;
  final double? buttonWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: buttonHeight ?? 50,
        margin: margin,
        width: buttonWidth ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.centerLeft, // Start the gradient from the left
              end: Alignment.centerRight, // End the gradient to the right
              colors: buttonColors ??
                  const [
                    Color(0xFF012A08), // Dark green
                    Color(0xFF65AF6C), // Lighter green
                  ]),
        ),
        child: Center(
          child: CustomTextsWidget(
              text: text,
              style: AppTextStyle.primaryTextStyle(
                  size: textSize ?? 16, color: textColor ?? Colors.white)),
        ),
      ),
    );
  }
}
