import 'package:facial_stadium/core/styles/app_colors.dart';
import 'package:facial_stadium/core/widgets/app_bar.dart';
import 'package:facial_stadium/core/widgets/brand_name_widget.dart';
import 'package:facial_stadium/core/widgets/custom_button.dart';
import 'package:facial_stadium/core/widgets/custom_text_widget.dart';
import 'package:facial_stadium/views/set_new_pass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckEmailScreen extends StatefulWidget {
  const CheckEmailScreen({super.key});

  @override
  State<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  String otp = '';
  bool isOtpValid = true;
  bool isOtpDone = false;
  void _verifyOtp() {
    setState(() {
      otp = _otpControllers.map((controller) => controller.text).join();
      isOtpValid = otp == '123456';
    });

    if (isOtpValid) {
      setState(() {
        isOtpDone = true;
      });
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
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: CustomAppBar(
          title: const BrandNameWidget(textSize: 15),
          leading: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Image.asset('assets/Picture1.png'),
          )),
      body: Padding(
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
              isOtpDone
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password Reset',
                          style: GoogleFonts.poppins(
                              fontSize: 24, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Your password has been successfully reset. click confirm to set a new password',
                          softWrap: true,
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.white),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                            onPressed: () {
                              Get.to(() => const SetNewPasswordScreen());
                            },
                            buttonWidth: MediaQuery.of(context).size.width,
                            textColor: Colors.white,
                            text: "Confirm"),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Check Your Email',
                          style: GoogleFonts.poppins(
                              fontSize: 24, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'We sent a rest link to your email \n enter 6 digit code that mentioned in the email',
                          softWrap: true,
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.white),
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
                                margin:
                                    const EdgeInsets.only(right: 8, left: 8),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 2),
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
                                                .map((controller) =>
                                                    controller.text)
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
                        // //////////////////////////////////////
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                            onPressed: _verifyOtp,
                            buttonWidth: MediaQuery.of(context).size.width,
                            textColor: Colors.white,
                            text: "Verify Code"),
                        const SizedBox(
                          height: 10,
                        ),
                        const Center(
                          child: CustomTextsWidget(
                            text: "Haven't got  the email yet? Resend email",
                            fontColor: Color.fromARGB(255, 193, 215, 228),
                          ),
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
