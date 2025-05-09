import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamy/data/cache_helper/cache_helper.dart';
import 'package:islamy/view/screens/home/home_screen.dart';
import 'package:islamy/view/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(
        context,
        CacheHelper.getEligibility() == true
            ? HomeScreen.routeName
            : OnboardingScreen.routeName,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        "assets/images/splash.png",
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
