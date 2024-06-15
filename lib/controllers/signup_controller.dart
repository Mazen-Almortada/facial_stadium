import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facial_stadium/core/services/firebase_storage_service.dart';
import 'package:facial_stadium/core/services/local_auth_utils.dart';
import 'package:facial_stadium/core/widgets/custom_snackbars.dart';
import 'package:facial_stadium/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class SignupController extends GetxController {
  var currentStep = 0.obs;
  var userModel = UserModel().obs;
  var selectedIndex = 0.obs;
  RxBool obscureText = true.obs;
  RxBool authenticated = false.obs;
  RxBool verifyingSignup = false.obs;
  Rx<File> image = File("").obs;
  FirebaseStorageService firebaseStorageService = FirebaseStorageService();

  Future<void> takePicture() async {
    try {
      var pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        image.value = File(pickedImage.path);

        if (!await _detectFaces(File(pickedImage.path))) {
          showCustomSnackBar(customSnackBarError(
              errorMessage: "no faces detecated in picture"));
        } else {
          verifyingSignup.value = true;
          await finishSignup();
        }
      }
    } catch (e) {
      showCustomSnackBar(customSnackBarError(errorMessage: "Something error "));
    }
  }

  bool faceDetecated = false;
  Future<bool> _detectFaces(File img) async {
    final faceDetector = FaceDetector(options: FaceDetectorOptions());
    final inputImage = InputImage.fromFilePath(img.path);
    final faces = await faceDetector.processImage(inputImage);
    if (faces.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void goToNext() {
    if (currentStep.value < 3) {
      currentStep.value++;
    }
  }

  void localAuth(context) async {
    if (!await LocalAuthUtils.isBiometricsSupported()) {
      showCustomSnackBar(customSnackBarError(
          errorMessage:
              "You must turn on Authentication with Biometrics in your settings"));
    } else {
      final didauth = await LocalAuthUtils.showFingerprintAuthDialog(context);
      if (didauth) {
        authenticated.value = true;
      }
    }
  }

  Future<void> checkUserInfo() async {
    final user = userModel.value;

    try {
      final querySnapshot = await _firestore.collection("users").get();

      bool isUserExist = querySnapshot.docs
          .map((doc) =>
              doc.data().containsKey('email') ? doc["email"] as String? : null)
          .where((email) => email != null)
          .toList()
          .any((email) => email == "${user.email}");
      if (isUserExist) {
        showCustomSnackBar(customSnackBarError(
            errorMessage:
                "That Email Address is already in use! Please try with a different one."));
      } else {
        goToNext();
      }
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(customSnackBarError(
          errorMessage: e.message ?? "error when createing account"));
    }
  }

  void changeObscureText() {
    obscureText.value = !obscureText.value;
  }

  void goToPrevious() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  Future<void> finishSignup() async {
    try {
      userModel.value.imageUrl = await firebaseStorageService.userPicture(
          userModel.value.email!, image.value);
      await auth
          .createUserWithEmailAndPassword(
              email: userModel.value.email!,
              password: userModel.value.password!)
          .then((user) async {
        await _setUserData(userModel.value, user.user!.uid);
      });

      showCustomSnackBar(customSnackBarSuccess(
          successMessage: "Account created successfully"));
      Get.offAllNamed('/verifydone');
    } on PlatformException catch (e) {
      showCustomSnackBar(customSnackBarError(errorMessage: "${e.message}"));
    } on FirebaseException catch (e) {
      showCustomSnackBar(customSnackBarError(errorMessage: "${e.message}"));
    } catch (e) {
      print(e);
      showCustomSnackBar(customSnackBarError(errorMessage: "Something error"));
    } finally {
      verifyingSignup.value = false;
    }
  }

  _setUserData(UserModel userModel, String userId) async {
    await _firestore.collection("users").doc(userId).set(userModel.toMap());
  }
}
