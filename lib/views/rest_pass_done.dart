import 'package:facial_stadium/core/styles/app_colors.dart';
import 'package:facial_stadium/core/widgets/brand_name_widget.dart';
import 'package:facial_stadium/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestPasswordDone extends StatelessWidget {
  const RestPasswordDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10),
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
              CustomButton(
                  onPressed: () {
                    Get.offAllNamed("/login");
                  },
                  buttonWidth: MediaQuery.of(context).size.width,
                  textColor: Colors.white,
                  text: "Back Login in App"),
              const SizedBox(
                height: 40,
              ),
              Icon(
                Icons.check_circle,
                color: Colors.lightGreen,
                size: MediaQuery.of(context).size.width / 3.5,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
