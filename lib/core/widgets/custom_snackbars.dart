import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customSnackBarSuccess({required String successMessage}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(minHeight: 90),
        decoration: const BoxDecoration(
          color: Color(0xFF0B7141), // #0B7141
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 48,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Well done!",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    successMessage, // Use the errorText parameter here
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 11,
                    ),

                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        bottom: 0,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
          ),
          child: SvgPicture.asset(
            "assets/icons/bubbles.svg",
            height: 48,
            width: 40,
            color: const Color(0xFF004E2F), //#004E2F
          ),
        ),
      ),
      Positioned(
        top: -14,
        left: 0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: SvgPicture.asset(
                "assets/icons/fail.svg",
                height: 40,
                color: const Color(0xFF004E2F),
              ),
            ),
            Positioned(
              top: 10,
              child: SvgPicture.asset(
                "assets/icons/check_mark.svg",
                height: 22,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget customSnackBarWarning({required String warningMessage}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(minHeight: 90),
        decoration: const BoxDecoration(
          color: Color(0xFFED8D2B), // #ED8D2B
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 48,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Warning..!",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    warningMessage, // Use the errorText parameter here
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        bottom: 0,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
          ),
          child: SvgPicture.asset(
            "assets/icons/bubbles.svg",
            height: 48,
            width: 40,
            color: const Color(0xFFCD571D), //#CD571D
          ),
        ),
      ),
      Positioned(
        top: -14,
        left: 0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: SvgPicture.asset(
                "assets/icons/fail.svg",
                height: 40,
                color: const Color(0xFFCD571D),
              ),
            ),
            Positioned(
              top: 5,
              child: SvgPicture.asset(
                "assets/icons/exclamation_mark.svg",
                height: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget customSnackBarError({required String errorMessage}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(minHeight: 90),
        decoration: const BoxDecoration(
          color: Color(0xFFC72C41),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 48,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Oops..!",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    errorMessage,
                    softWrap: true,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        bottom: 0,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
          ),
          child: SvgPicture.asset(
            "assets/icons/bubbles.svg",
            height: 48,
            width: 40,
            color: const Color(0xFF801336),
          ),
        ),
      ),
      Positioned(
        top: -14,
        left: 0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: SvgPicture.asset(
                "assets/icons/fail.svg",
                height: 40,
              ),
            ),
            Positioned(
              top: 10,
              child: SvgPicture.asset(
                "assets/icons/close.svg",
                height: 16,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

void showCustomSnackBar(Widget snackBarWidget) {
  Get.snackbar(
    "", // Title is required but can be empty.
    "", // Message is required but can be empty.
    titleText: const SizedBox
        .shrink(), // Use SizedBox.shrink() to effectively remove the space for the title.
    messageText: snackBarWidget, // Your custom widget as the main content.
    snackPosition:
        SnackPosition.BOTTOM, // Or TOP, depending on your preference.
    backgroundColor: Colors.transparent,
    margin: const EdgeInsets.all(10),
    padding: EdgeInsets.zero,
    duration: const Duration(seconds: 4),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    overlayBlur: 0, // You can set this to a value for a blur effect.
    overlayColor: Colors.transparent, // Ensures no additional color overlay.
    boxShadows: [
      const BoxShadow(color: Colors.transparent)
    ], // Removes default shadow if not needed.
  );
}
