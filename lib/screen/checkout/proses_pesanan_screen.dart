import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/constant/color_constant.dart';
import 'package:mini_project/constant/text_style_constant.dart';
import 'package:mini_project/gen/assets_gen.dart';
import 'package:mini_project/screen/main/home_main_screen.dart';

class ProsesPesananScreen extends StatefulWidget {
  const ProsesPesananScreen({super.key});

  @override
  State<ProsesPesananScreen> createState() => _ProsesPesananScreen();
}

class _ProsesPesananScreen extends State<ProsesPesananScreen> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Assets.image.checkDone.image(),
      title: Text(
        "Pesanan Anda Sedang Diproses",
        style: TextStyleConstant.ibmPlexSans.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      backgroundColor: ColorConstant.blueAccent,
      showLoader: true,
      loaderColor: ColorConstant.foregroundColor,
      navigator: HomeMain(currentIndex: 0),
      durationInSeconds: 5,
    );
  }
}
