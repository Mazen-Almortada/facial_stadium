import 'dart:async';

import 'package:facial_stadium/controllers/signup_controller.dart';
import 'package:facial_stadium/core/styles/app_colors.dart';
import 'package:facial_stadium/core/styles/app_text_style.dart';
import 'package:facial_stadium/core/widgets/custom_button.dart';
import 'package:facial_stadium/core/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key, required this.signupController});
  final SignupController signupController;

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  String otp = '';
  bool isOtpValid = true;
  late Timer _timer;
  int _start = 60;
  String _buttonText = 'Resend OTP in 0:60';
  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }

    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _buttonText = 'Confirm';
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
          _buttonText = 'Resend OTP in 0:$_start';
        });
      }
    });
  }

  void _verifyOtp() {
    setState(() {
      otp = _otpControllers.map((controller) => controller.text).join();
      isOtpValid = otp == '123456';
    });

    if (isOtpValid) {
      widget.signupController.goToNext();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.email, size: 100, color: Color(0xffa7cdba)),
          const SizedBox(height: 15),
          CustomTextsWidget(
            text: 'Verify your email',
            style: AppTextStyle.primaryTextStyle(size: 24, color: Colors.black),
          ),
          const SizedBox(height: 10),
          CustomTextsWidget(
            text:
                'Kindly input the code sent to your email address for confirmation',
            textAlign: TextAlign.center,
            style: AppTextStyle.secondaryTextStyle(
              size: 18,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.signupController.userModel.value.email ?? "",
                    style:
                        GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.black),
                  onPressed: () {
                    widget.signupController.goToPrevious();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) {
              return Expanded(
                child: Container(
                  alignment: Alignment.center,
                  width: 40,
                  height: 50,
                  margin: const EdgeInsets.only(right: 8, left: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _otpControllers[index],
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                    ),
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: isOtpValid
                            ? AppColors.blueColor
                            : AppColors.redColor),
                    onChanged: (value) {
                      if (_otpControllers
                                  .map((controller) => controller.text)
                                  .join()
                                  .length <=
                              5 &&
                          isOtpValid == false) {
                        setState(() {
                          isOtpValid = true;
                        });
                      }

                      if (value.length == 1 && index < 5) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              setState(() {
                _start = 60;
              });
              startTimer();
            },
            child: CustomTextsWidget(
              text: "Didn't receive any code?",
              style: AppTextStyle.primaryTextStyle(
                  size: 14, color: AppColors.subTitleColor),
            ),
          ),
          const SizedBox(height: 10),
          CustomButton(
              onPressed: _start == 0 ? _verifyOtp : null,
              buttonHeight: 65,
              textColor: Colors.black,
              text: _buttonText),
        ],
      ),
    );
  }
}
