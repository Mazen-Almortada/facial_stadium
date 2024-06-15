import 'package:facial_stadium/core/widgets/custom_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthUtils {
  static Future<bool> showFingerprintAuthDialog(BuildContext context) async {
    final localAuth = LocalAuthentication();

    final bool canAuth = await isBiometricsSupported();

    if (canAuth) {
      try {
        final bool didauth = await localAuth.authenticate(
            localizedReason: "Authinticate",
            options: const AuthenticationOptions(
              biometricOnly: true,
            ));

        if (didauth) {
          return true;
        }
      } on PlatformException catch (e) {
        String? message;

        switch (e.code) {
          case "PermanentlyLockedOut":
            message = lockedOutMessage;
            localAuth.stopAuthentication();
            break;

          case "LockedOut":
            message = manyAttemptsMessage;
            break;
          default:
            {
              message = somethingErrorMessage;
            }
        }
        showCustomSnackBar(customSnackBarError(errorMessage: message));
      }
    }
    return false;
  }

  static Future<bool> isBiometricsSupported() async {
    final localAuth = LocalAuthentication();

    final bool canAuthWithBiometrics = await localAuth.canCheckBiometrics;
    final bool canAuth =
        canAuthWithBiometrics || await localAuth.isDeviceSupported();
    return canAuth;
  }
}

// Local Auth
const String lockedOutMessage =
    "too many times. Biometric authentication is disabled until the user unlocks with strong authentication (PIN/Pattern/Password)";
const String manyAttemptsMessage =
    "too many attempts. This occurs after 5 failed attempts, and lasts for 30 seconds.";

const String somethingErrorMessage = " Something Error";
