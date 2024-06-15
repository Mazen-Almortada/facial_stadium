import 'package:facial_stadium/controllers/signup_controller.dart';
import 'package:facial_stadium/core/styles/app_colors.dart';
import 'package:facial_stadium/core/styles/app_text_style.dart';
import 'package:facial_stadium/core/widgets/app_bar.dart';
import 'package:facial_stadium/core/widgets/brand_name_widget.dart';
import 'package:facial_stadium/core/widgets/custom_button.dart';
import 'package:facial_stadium/core/widgets/custom_text_form_field.dart';
import 'package:facial_stadium/core/widgets/custom_text_widget.dart';
import 'package:facial_stadium/core/widgets/otp_verification_screen.dart';
import 'package:facial_stadium/core/widgets/stroke_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignupController controller = Get.put(SignupController());

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
      body: Obx(() => SizedBox(
            child: Theme(
              data: ThemeData(canvasColor: AppColors.primaryColor),
              child: Stepper(
                controlsBuilder: (context, controller) {
                  return const SizedBox.shrink();
                },
                elevation: 0,
                type: StepperType.horizontal,
                currentStep: controller.currentStep.value,
                onStepContinue: controller.currentStep.value == 3
                    ? controller.finishSignup
                    : controller.goToNext,
                onStepCancel: controller.goToPrevious,
                steps: [
                  Step(
                    title: const Text(''),
                    content: _accountForm(controller),
                    isActive: controller.currentStep.value >= 0,
                    state: controller.currentStep.value > 0
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text(''),
                    content: verifyEmail(controller),
                    isActive: controller.currentStep.value >= 1,
                    state: controller.currentStep.value > 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text(''),
                    content: _localAuth(controller),
                    isActive: controller.currentStep.value >= 2,
                    state: controller.currentStep.value > 2
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text(''),
                    content: sginUpFinish(controller),
                    isActive: controller.currentStep.value >= 3,
                    state: controller.currentStep.value == 3
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  final GlobalKey<FormState> formKey = GlobalKey();
  Widget sginUpFinish(SignupController controller) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Image.asset('assets/Picture1.png',
                  width: MediaQuery.of(context).size.width * 0.25),
              const SizedBox(
                height: 10,
              ),
              const BrandNameWidget(
                textSize: 18,
              ),
              const SizedBox(
                height: 35,
              ),
              controller.verifyingSignup.value
                  ? CustomTextsWidget(
                      textAlign: TextAlign.center,
                      text: "Verifying....",
                      style: AppTextStyle.primaryTextStyle(
                        size: 15,
                        color: AppColors.thirdColor,
                      ))
                  : Column(
                      children: [
                        CustomTextsWidget(
                            textAlign: TextAlign.center,
                            text:
                                "Activate Facial Recognition mode to enter the stadium",
                            style: AppTextStyle.primaryTextStyle(
                              size: 15,
                              color: AppColors.thirdColor,
                            )),
                        const SizedBox(
                          height: 35,
                        ),
                        CustomButton(
                            buttonWidth: MediaQuery.of(context).size.width / 2,
                            onPressed: () {
                              controller.takePicture();
                            },
                            text: "Take a selfie")
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget _accountForm(SignupController controller) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextsWidget(
                text: "Let's get you started",
                textAlign: TextAlign.left,
                fontSize: 16,
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomTextsWidget(
                text: "First Name",
                fontColor: Colors.lightGreen,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextFormField(
                  onSaved: (value) {
                    controller.userModel.value.firstName = value;
                  },
                  hintText: "Your First Name"),
              const SizedBox(
                height: 10,
              ),
              const CustomTextsWidget(
                text: "Last Name",
                fontColor: Colors.lightGreen,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextFormField(
                  onSaved: (value) {
                    controller.userModel.value.lastName = value;
                  },
                  hintText: "Your Last Name"),
              const SizedBox(
                height: 10,
              ),
              const CustomTextsWidget(
                text: "Email Address",
                fontColor: Colors.lightGreen,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextFormField(
                  onSaved: (value) {
                    controller.userModel.value.email = value;
                  },
                  hintText: "Your Email Address"),
              const SizedBox(
                height: 10,
              ),
              const CustomTextsWidget(
                text: "Address 1",
                fontColor: Colors.lightGreen,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextFormField(
                  onSaved: (value) {
                    controller.userModel.value.address1 = value;
                  },
                  hintText: "Your Address 1"),
              const SizedBox(
                height: 10,
              ),
              const CustomTextsWidget(
                text: "Address 2",
                fontColor: Colors.lightGreen,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextFormField(
                  onSaved: (value) {
                    controller.userModel.value.address2 = value;
                  },
                  hintText: "Your Address 2"),
              const SizedBox(
                height: 10,
              ),
              const CustomTextsWidget(
                text: "Phone Number",
                fontColor: Colors.lightGreen,
              ),
              const SizedBox(
                height: 5,
              ),
              IntlPhoneField(
                autofocus: true,
                autovalidateMode: AutovalidateMode.always,
                dropdownIconPosition: IconPosition.trailing,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 194, 190, 190))),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 194, 190, 190), width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  filled: true,
                  counter: const SizedBox(),
                  contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                  hintText: 'Your Phone Number',
                  hintStyle: AppTextStyle.primaryTextStyle(
                      color: const Color.fromARGB(255, 194, 190, 190),
                      size: 15),
                  fillColor: const Color(0xFF616935),
                ),
                initialCountryCode: 'MY',
                validator: (phone) {
                  String? phoneNumber = phone?.number;
                  if (phoneNumber?.isEmpty ?? true) {
                    return "Field cannot be empty";
                  }
                  return null;
                },
                onSaved: (phone) {
                  controller.userModel.value.phoneNumber =
                      phone?.completeNumber;
                },
              ),
              const SizedBox(
                height: 5,
              ),
              const CustomTextsWidget(
                text: "Password",
                fontColor: Colors.lightGreen,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextFormField(
                onSaved: (value) {
                  controller.userModel.value.password = value;
                },
                obscureText: controller.obscureText.value,
                hintText: "Your Password",
                suffixIcon: GestureDetector(
                    onTap: () {
                      controller.changeObscureText();
                    },
                    child: Icon(
                      controller.obscureText.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.blackColor,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Column(
                  children: [
                    CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            Get.showOverlay(
                              loadingWidget: const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                              asyncFunction: () async {
                                await controller.checkUserInfo();
                              },
                            );
                          }
                        },
                        buttonWidth: MediaQuery.of(context).size.width / 2,
                        textColor: const Color.fromARGB(255, 201, 80, 121),
                        text: "Next"),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.offNamed("/login");
                        },
                        child: const CustomTextsWidget(
                          text: "Do you have an account? Sign in",
                          fontColor: Color.fromARGB(255, 201, 80, 121),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget verifyEmail(SignupController controller) {
    return SingleChildScrollView(
      child: OTPVerificationScreen(
        signupController: controller,
      ),
    );
  }

  Widget _localAuth(SignupController controller) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              Image.asset('assets/Picture1.png',
                  width: MediaQuery.of(context).size.width * 0.25),
              const SizedBox(
                height: 10,
              ),
              const BrandNameWidget(
                textSize: 15,
              ),
              const SizedBox(
                height: 35,
              ),
              CustomTextsWidget(
                text: 'Verify It,s You',
                style: AppTextStyle.primaryTextStyle(
                    size: 24, color: Colors.lightGreen),
              ),
              const SizedBox(height: 20),
              !controller.authenticated.value
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
                              controller.selectedIndex.value = 0;
                            }, controller.selectedIndex.value),
                            SizedBox(
                              width: MediaQuery.of(context).size.width > 400
                                  ? 30
                                  : 20,
                            ),
                            authOptions(
                                "Choose the Face ID", 1, "assets/face.png", () {
                              controller.selectedIndex.value = 1;
                            }, controller.selectedIndex.value),
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
                            buttonWidth: MediaQuery.of(context).size.width / 2,
                            onPressed: () {
                              controller.localAuth(context);
                            },
                            text: "Confirm")
                      ],
                    )
                  : Column(
                      children: [
                        StrokeTextWidget(
                          "You can use ${controller.selectedIndex.value == 0 ? "Fingerprint" : "Face"} authentication to confirm making payments through this app",
                          textAlign: TextAlign.center,
                          fontSize: 15,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        controller.selectedIndex.value == 1
                            ? Center(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.goToNext();
                                      },
                                      child: Image.asset(
                                        "assets/faceavatar.png",
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const CustomTextsWidget(
                                      fontSize: 12,
                                      text: "Tap Face ID to complate",
                                      fontColor: Colors.white,
                                    )
                                  ],
                                ),
                              )
                            : Center(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          controller.goToNext();
                                        },
                                        child: Image.asset(
                                            "assets/fingerprint.png",
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const CustomTextsWidget(
                                      fontSize: 12,
                                      text: "Tap Fingerprint ID to complate",
                                      fontColor: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.lightGreen,
                          size: MediaQuery.of(context).size.width / 3.5,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomTextsWidget(
                          textAlign: TextAlign.center,
                          text: "Authentication Process Successful",
                          fontColor: Colors.green,
                          fontSize: 18,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const StrokeTextWidget(
                          "Your account has been successfully verified. Enjoy our services onwards.",
                          textAlign: TextAlign.center,
                          strokeColor: Colors.lightGreen,
                          textColor: Colors.white,
                          fontSize: 11,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
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
}
