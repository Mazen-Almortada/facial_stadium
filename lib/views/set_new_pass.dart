import 'package:facial_stadium/core/styles/app_colors.dart';
import 'package:facial_stadium/core/widgets/app_bar.dart';
import 'package:facial_stadium/core/widgets/brand_name_widget.dart';
import 'package:facial_stadium/core/widgets/custom_button.dart';
import 'package:facial_stadium/core/widgets/custom_snackbars.dart';
import 'package:facial_stadium/core/widgets/custom_text_form_field.dart';
import 'package:facial_stadium/core/widgets/custom_text_widget.dart';
import 'package:facial_stadium/views/check_email_screen.dart';
import 'package:facial_stadium/views/rest_pass_done.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController pass = TextEditingController(text: "");
  final TextEditingController confirmPass = TextEditingController(text: "");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: CustomAppBar(
          title: const BrandNameWidget(textSize: 15),
          leading: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Image.asset('assets/Picture1.png'),
          )),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 91, 129, 48),
                    radius: 25,
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Set a new password',
                  softWrap: true,
                  style: GoogleFonts.poppins(fontSize: 24, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  'Create a new password. Ensure it differs from previous ones for security',
                  softWrap: true,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                ),
                const SizedBox(height: 20),
                const CustomTextsWidget(
                  text: "Password",
                  fontColor: Colors.lightGreen,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextFormField(
                    controller: pass,
                    obscureText: true,
                    hintText: "Enter Your New Password"),
                const SizedBox(height: 20),
                const CustomTextsWidget(
                  text: "Confirm Password",
                  fontColor: Colors.lightGreen,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextFormField(
                    obscureText: true,
                    controller: confirmPass,
                    hintText: "Re-enter Password"),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 20),
                CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (pass.text != confirmPass.text) {
                          showCustomSnackBar(customSnackBarError(
                              errorMessage: "Password does  not match"));
                        } else {
                          Get.to(() => const RestPasswordDone());
                        }
                      }
                    },
                    buttonWidth: MediaQuery.of(context).size.width,
                    textColor: Colors.white,
                    text: "Update Password"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
