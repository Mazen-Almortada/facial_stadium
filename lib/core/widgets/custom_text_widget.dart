import 'package:facial_stadium/core/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomTextsWidget extends StatelessWidget {
  final String text;

  final TextAlign? textAlign;
  final TextStyle? style;
  final double? fontSize;
  final Color? fontColor;
  final TextDirection? textDirection;
  const CustomTextsWidget(
      {required this.text,
      this.style,
      super.key,
      this.textDirection,
      this.textAlign,
      this.fontSize,
      this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        softWrap: true,
        textAlign: textAlign ?? TextAlign.left,
        textDirection: textDirection ?? TextDirection.ltr,
        style: style ??
            AppTextStyle.primaryTextStyle(
                size: fontSize ?? 13, color: fontColor));
  }
}
