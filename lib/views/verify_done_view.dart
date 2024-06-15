import 'package:facial_stadium/core/styles/app_colors.dart';
import 'package:facial_stadium/core/styles/app_text_style.dart';
import 'package:facial_stadium/core/widgets/brand_name_widget.dart';
import 'package:facial_stadium/core/widgets/custom_text_widget.dart';
import 'package:facial_stadium/core/widgets/stroke_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyDoneWidget extends StatelessWidget {
  const VerifyDoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Image.asset('assets/Picture1.png',
                width: MediaQuery.of(context).size.width * 0.50),
            const SizedBox(
              height: 10,
            ),
            const BrandNameWidget(
              textSize: 25,
            ),
            const SizedBox(
              height: 50,
            ),
            CustomTextsWidget(
              text: 'Verify Successful',
              style: AppTextStyle.primaryTextStyle(
                  size: 22, color: Colors.lightGreen),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Get.offAllNamed('/home');
              },
              child: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 91, 129, 48),
                radius: 30,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const StrokeTextWidget(
              'Go to Home Page',
              textAlign: TextAlign.center,
              strokeColor: Colors.lightGreen,
              textColor: Colors.white,
              strokeWidth: 3,
              fontSize: 15,
            ),
          ],
        ),
      )),
    );
  }
}
