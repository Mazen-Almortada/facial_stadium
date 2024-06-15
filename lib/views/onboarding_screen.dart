import 'package:facial_stadium/core/styles/app_colors.dart';
import 'package:facial_stadium/core/styles/app_text_style.dart';
import 'package:facial_stadium/core/widgets/brand_name_widget.dart';
import 'package:facial_stadium/core/widgets/custom_button.dart';
import 'package:facial_stadium/core/widgets/custom_text_widget.dart';
import 'package:facial_stadium/core/widgets/stroke_text_widget.dart';
import 'package:facial_stadium/models/onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({super.key});

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            colors: [
              Color(0xFF2D1D2A),
              Color(0xFF2E917F),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/Picture1.png',
                    width: MediaQuery.of(context).size.width * 0.40),
                const SizedBox(
                  height: 10,
                ),
                const BrandNameWidget(
                  textSize: 18,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingContentsList.length,
                    (index) => buildDot(index, context),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 250,
                  child: PageView.builder(
                    controller: _controller,
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    itemCount: onboardingContentsList.length,
                    itemBuilder: (context, i) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextsWidget(
                                  textAlign: TextAlign.center,
                                  text: onboardingContentsList[i].title,
                                  style: AppTextStyle.primaryTextStyle(
                                    size: 17,
                                    color: AppColors.thirdColor,
                                  )),
                              const SizedBox(height: 40),
                              StrokeTextWidget(
                                onboardingContentsList[i].discription,
                                textAlign: TextAlign.center,
                                fontSize: 20,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                currentIndex == 1
                    ? CustomButton(
                        onPressed: () {
                          Get.toNamed("/signup");
                        },
                        margin: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                        text: "Get started",
                        buttonColors: const [
                          Color(0xFF1F5C19), // Solid color
                          Color(
                              0xD9AF6580), // Semi-transparent color, converted from rgba(175, 101, 128, 0.85)
                        ],
                      )
                    : const SizedBox(),
                CustomButton(
                  onPressed: () {
                    if (currentIndex == onboardingContentsList.length - 1) {
                      Get.toNamed("/login");
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  margin: const EdgeInsets.fromLTRB(40, 5, 40, 30),
                  text: currentIndex == onboardingContentsList.length - 1
                      ? "Login"
                      : "Next",
                  buttonColors: const [
                    Color(0xFF012A08), // Dark green
                    Color(0xFF65AF6C), // Lighter green
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.blueColor,
      ),
    );
  }
}
