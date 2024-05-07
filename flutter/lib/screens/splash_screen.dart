import 'package:female_health/routes/route_name.dart';
import 'package:female_health/utils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:femhealth/utils/route_name.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void changeScreen() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Navigator.of(context).pushNamed(RouteName.onboarding);
    });
  }

  Future<void> gotoNextScreen() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool onboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    await Future.delayed(const Duration(seconds: 3));
    // FirebaseAuth auth = FirebaseAuth.instance;
    {
      if (!isLoggedIn) {
        Navigator.of(context).pushNamed(RouteName.onboarding);
      } else {
        Navigator.of(context).pushNamed(RouteName.navBar);
      }
    }
  }

  @override
  void initState() {
    gotoNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: Image.asset(
            ImagePath.appLogo,
            width: 150,
          ),
        ));
  }
}
