import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/constant/color_constant.dart';
import 'package:mini_project/constant/text_style_constant.dart';
import 'package:mini_project/gen/assets_gen.dart';
import 'package:mini_project/screen/main/home_main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Assets.image.astronautImut.image(),
      title: Text(
        "Space Store App",
        style: TextStyleConstant.bebasNeueBold.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
      ),
      backgroundColor: ColorConstant.backgroundColor,
      showLoader: true,
      navigator: HomeMain(currentIndex: 0),
      durationInSeconds: 3,
    );
  }
}
