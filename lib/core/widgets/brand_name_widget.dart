import 'package:facial_stadium/core/strings/app_strings.dart';
import 'package:facial_stadium/core/styles/app_text_style.dart';
import 'package:facial_stadium/core/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class BrandNameWidget extends StatelessWidget {
  final TextAlign? textAlign;
  final double? textSize;
  const BrandNameWidget({super.key, this.textAlign, this.textSize});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(colors: [
        Color.fromARGB(255, 212, 53, 42),
        Color.fromRGBO(82, 197, 88, 1)
      ]).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: CustomTextsWidget(
        text: appName,
        style: AppTextStyle.brandNameTextStyle(
          size: textSize,
        ),
        textAlign: textAlign ?? TextAlign.center,
      ),
    );
  }
}
