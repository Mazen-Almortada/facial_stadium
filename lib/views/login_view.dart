import 'package:facial_stadium/core/styles/app_colors.dart';
import 'package:facial_stadium/core/widgets/app_bar.dart';
import 'package:facial_stadium/core/widgets/brand_name_widget.dart';
import 'package:facial_stadium/core/widgets/custom_button.dart';
import 'package:facial_stadium/core/widgets/custom_text_form_field.dart';
import 'package:facial_stadium/core/widgets/custom_text_widget.dart';
import 'package:facial_stadium/core/widgets/stroke_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // Instantiate your AuthController

    final AuthController authController = Get.put(AuthController());

    // Check login status after a delay

    return Scaffold(
        appBar: CustomAppBar(
            title: const BrandNameWidget(textSize: 15),
            leading: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Image.asset('assets/Picture1.png'),
            )),
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Obx(() {
            return SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Center(
                        child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: StrokeTextWidget(
                              'Login',
                              textAlign: TextAlign.center,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          const CustomTextsWidget(
                            textAlign: TextAlign.left,
                            text: "Email",
                            fontColor: Colors.lightGreen,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFormField(
                              onSaved: (value) {
                                authController.email.value = value!;
                              },
                              hintText: "Your Email"),
                          const SizedBox(
                            height: 10,
                          ),
                          const CustomTextsWidget(
                            textAlign: TextAlign.left,
                            text: "Password",
                            fontColor: Colors.lightGreen,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFormField(
                            onSaved: (value) {
                              authController.password.value = value!;
                            },
                            obscureText: authController.obscureText.value,
                            hintText: "Your Password",
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  authController.changeObscureText();
                                },
                                child: Icon(
                                  authController.obscureText.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.blackColor,
                                )),
                          ),
                          const SizedBox(
                            height: 30,
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
                                            await authController.login();
                                          },
                                        );
                                      }
                                    },
                                    buttonWidth:
                                        MediaQuery.of(context).size.width / 1.5,
                                    textColor: Colors.white,
                                    text: "Login"),
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Get.toNamed("/forgotpass");
                                    },
                                    child: const Align(
                                      alignment: Alignment.centerRight,
                                      child: CustomTextsWidget(
                                          textAlign: TextAlign.end,
                                          text: "Forgot Password? ",
                                          fontColor: AppColors.blueColor),
                                    )),
                                const SizedBox(
                                  height: 50,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomTextsWidget(
                                          textAlign: TextAlign.end,
                                          text: "Do you have not an account? ",
                                          fontColor: const Color.fromARGB(
                                                  255, 248, 67, 188)
                                              .withOpacity(0.5)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.offNamed("/signup");
                                        },
                                        child: const CustomTextsWidget(
                                          textAlign: TextAlign.end,
                                          text: "Sign Up? ",
                                          fontColor:
                                              Color.fromARGB(255, 201, 80, 121),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ))));
          }),
        ));
  }
}
