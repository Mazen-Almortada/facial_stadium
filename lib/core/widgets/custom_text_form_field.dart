import 'package:facial_stadium/core/styles/app_colors.dart';
import 'package:facial_stadium/core/styles/app_text_style.dart';
import 'package:facial_stadium/core/utils/password_validator.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {required this.hintText,
      this.obscureText = false,
      this.prefixIcon,
      this.suffixIcon,
      super.key,
      this.onSaved,
      this.fillColor,
      this.controller,
      this.keyboardType,
      this.hintColor,
      this.onChanged});
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final bool obscureText;
  final Color? fillColor;
  final Color? hintColor;
  final String hintText;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: false,
        keyboardType: keyboardType,
        onSaved: onSaved,
        obscureText: obscureText,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return "Field cannot be empty";
          } else {
            if (obscureText && validatePasswordStrong(value!) == false) {
              return "password must be at least 8 characters \nwith uppercase,lowercase,number and symbol";
            }
            return null;
          }
        },
        textInputAction: TextInputAction.next,
        onChanged: onChanged,
        onTap: () {
          if (controller != null) {
            if (controller!.selection ==
                TextSelection.fromPosition(
                    TextPosition(offset: controller!.text.length - 1))) {
              controller!.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller!.text.length));
            }
          }
        },
        controller: controller,
        decoration: InputDecoration(
          errorMaxLines: 2,
          errorStyle:
              obscureText ? AppTextStyle.primaryTextStyle(size: 10) : null,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: fillColor ?? const Color(0xFF616935),
          contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          hintText: hintText,
          hintStyle: AppTextStyle.primaryTextStyle(
              size: 15,
              color: hintColor ?? const Color.fromARGB(255, 194, 190, 190)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 194, 190, 190))),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 194, 190, 190), width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
        ));
  }
}
