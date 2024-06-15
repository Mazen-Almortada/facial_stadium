import 'package:facial_stadium/core/styles/app_colors.dart';
import 'package:facial_stadium/core/widgets/brand_name_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate your AuthController
    final AuthController authController = Get.put(AuthController());

    // Check login status after a delay
    Future.delayed(const Duration(seconds: 5), () {
      if (authController.isLoggedIn) {
        Get.offAllNamed('/home'); // Navigate to home if logged in
      } else {
        Get.offAllNamed('/onboarding'); // Navigate to login if not logged in
      }
    });

    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/Picture1.png',
                      width: MediaQuery.of(context).size.width * 0.62),
                  const SizedBox(
                    height: 10,
                  ),
                  const BrandNameWidget(
                    textSize: 22,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
