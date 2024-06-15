import 'package:facial_stadium/core/widgets/brand_name_widget.dart';
import 'package:facial_stadium/views/forgot_password.dart';
import 'package:facial_stadium/views/home_screen.dart';
import 'package:facial_stadium/views/login_screen.dart';
import 'package:facial_stadium/views/login_view.dart';
import 'package:facial_stadium/views/onboarding_screen.dart';
import 'package:facial_stadium/views/signup_screen.dart';
import 'package:facial_stadium/views/splash_screen.dart';
import 'package:facial_stadium/views/verify_done_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Facial Stadium',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        // ignore: deprecated_member_use
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/onboarding', page: () => const OnbordingScreen()),
        GetPage(name: '/signup', page: () => const SignUpScreen()),
        GetPage(name: '/loginview', page: () => LoginView()),
        GetPage(name: '/verifydone', page: () => const VerifyDoneWidget()),
        GetPage(name: '/forgotpass', page: () => const ForgotPasswordScreen()),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("facial stadium"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [BrandNameWidget()],
        ),
      ),
    );
  }
}
