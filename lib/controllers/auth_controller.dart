import 'package:facial_stadium/core/services/local_auth_utils.dart';
import 'package:facial_stadium/core/widgets/custom_snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();
  final RxBool showLocalAuth = false.obs;
  RxBool obscureText = true.obs;
  RxBool loginDone = false.obs;

  var email = "".obs;
  var password = "".obs;
  User? get user => _firebaseUser.value;
  var selectedIndex = 0.obs;
  void localAuth(context) async {
    if (!await LocalAuthUtils.isBiometricsSupported()) {
      showCustomSnackBar(customSnackBarError(
          errorMessage:
              "You must turn on Authentication with Biometrics in your settings"));
    } else {
      final didauth = await LocalAuthUtils.showFingerprintAuthDialog(context);
      if (didauth) {
        Get.toNamed("/loginview");
      }
    }
  }

  void changeObscureText() {
    obscureText.value = !obscureText.value;
  }

  Future<void> login() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.value, password: password.value);
      showCustomSnackBar(
          customSnackBarSuccess(successMessage: "login success"));
      Get.offAllNamed('/verifydone');
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(customSnackBarError(errorMessage: "${e.message}"));
    }
  }

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  bool get isLoggedIn => user != null;
}
