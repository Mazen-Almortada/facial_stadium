import 'package:facial_stadium/core/styles/app_text_style.dart';
import 'package:facial_stadium/core/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class StrokeTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool bold;
  final TextAlign? textAlign;
  final Color strokeColor;
  final double? strokeWidth;
  final Color? textColor;
  const StrokeTextWidget(
    this.text, {
    Key? key,
    this.fontSize = 18,
    this.strokeColor = Colors.black,
    this.bold = false,
    this.textAlign,
    this.textColor,
    this.strokeWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Stroke
        CustomTextsWidget(
            textAlign: textAlign,
            text: text,
            style: AppTextStyle.secondaryTextStyle(
                    color: strokeColor, bold: bold, size: fontSize)
                .copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = strokeWidth ?? 1
                ..color = strokeColor,
            )),
        // Solid text
        CustomTextsWidget(
            textAlign: textAlign,
            text: text,
            style: AppTextStyle.secondaryTextStyle(
                bold: bold, color: textColor, size: fontSize)),
      ],
    );
  }
}
