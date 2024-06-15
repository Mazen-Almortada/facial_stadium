import 'package:facial_stadium/core/styles/app_colors.dart';
import 'package:facial_stadium/core/widgets/brand_name_widget.dart';
import 'package:facial_stadium/core/widgets/custom_button.dart';
import 'package:facial_stadium/core/widgets/custom_text_widget.dart';
import 'package:facial_stadium/core/widgets/stroke_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate your AuthController
    final AuthController authController = Get.put(AuthController());

    // Check login status after a delay
    Future.delayed(const Duration(seconds: 5), () {
      authController.showLocalAuth.value = true;
    });

    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Obx(() {
            return SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: authController.showLocalAuth.value
                      ? Column(
                          children: [
                            const StrokeTextWidget(
                              'You can use face or fingerprint authentication \n to confirm this phone through this app',
                              textAlign: TextAlign.center,
                              strokeColor: Colors.lightGreen,
                              textColor: Colors.white,
                              fontSize: 13,
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                authOptions("Choose the Fingerprint ID ", 0,
                                    "assets/finger.png", () {
                                  authController.selectedIndex.value = 0;
                                }, authController.selectedIndex.value),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width > 400
                                      ? 30
                                      : 20,
                                ),
                                authOptions(
                                    "Choose the Face ID", 1, "assets/face.png",
                                    () {
                                  authController.selectedIndex.value = 1;
                                }, authController.selectedIndex.value),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const CustomTextsWidget(
                              fontSize: 12,
                              textAlign: TextAlign.center,
                              text: "Tap Confirm to complate",
                              fontColor: AppColors.subTitleColor,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomButton(
                                buttonHeight: 60,
                                buttonWidth:
                                    MediaQuery.of(context).size.width / 2,
                                onPressed: () {
                                  authController.localAuth(context);
                                  // Get.toNamed("/loginview");
                                },
                                text: "Confirm")
                          ],
                        )
                      : loginSplash(context)),
            );
          }),
        ));
  }

  Widget authOptions(String text, int id, String imagePath,
      void Function()? onTap, currentIndex) {
    return Expanded(
        child: Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(5),
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: id == currentIndex
                  ? Border.all(width: 2, color: AppColors.blueColor)
                  : null,
              color: const Color(0xff669172),
            ),
            child: Image.asset(imagePath),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: CustomTextsWidget(
              fontSize: 10,
              textAlign: TextAlign.center,
              text: text,
              fontColor: AppColors.subTitleColor,
            ))
      ],
    ));
  }

  Widget loginSplash(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/Picture1.png',
            width: MediaQuery.of(context).size.width * 0.50),
        const SizedBox(
          height: 10,
        ),
        const BrandNameWidget(
          textSize: 22,
        ),
        const SizedBox(
          height: 25,
        ),
        const StrokeTextWidget(
          'Welcome to our app',
          textAlign: TextAlign.center,
          fontSize: 18,
        ),
      ],
    );
  }
}
