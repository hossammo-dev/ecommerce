import 'dart:async';

import 'package:ecommerce/layouts/home_layout.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';
import '../shared/widgets/components.dart';
import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => navigateReplace(context,
            page:
                (Constants.userId == '') ? AuthScreen() : const HomeLayout()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(Constants.appLogo),
        ),
      ),
    );
  }
}
