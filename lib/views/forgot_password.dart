import 'package:facial_stadium/core/styles/app_colors.dart';
import 'package:facial_stadium/core/widgets/app_bar.dart';
import 'package:facial_stadium/core/widgets/brand_name_widget.dart';
import 'package:facial_stadium/core/widgets/custom_button.dart';
import 'package:facial_stadium/core/widgets/custom_text_form_field.dart';
import 'package:facial_stadium/core/widgets/custom_text_widget.dart';
import 'package:facial_stadium/views/check_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String email = "";
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
                  'Forgot password',
                  softWrap: true,
                  style: GoogleFonts.poppins(fontSize: 24, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please enter your email to reset the password',
                  softWrap: true,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                ),
                const SizedBox(height: 20),
                const CustomTextsWidget(
                  text: "Your Email",
                  fontColor: Colors.lightGreen,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextFormField(
                    onSaved: (value) {
                      email = value!;
                    },
                    hintText: "Enter Your Email"),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 20),
                CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Get.to(const CheckEmailScreen());
                      }
                    },
                    buttonWidth: MediaQuery.of(context).size.width,
                    textColor: Colors.white,
                    text: "Reset Password"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
