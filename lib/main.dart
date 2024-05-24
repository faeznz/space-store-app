import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:mini_project/constant/color_constant.dart';
import 'package:mini_project/env/env.dart';
import 'package:mini_project/provider/ai_area_provider.dart';
import 'package:mini_project/screen/splash_screen/splash_screen.dart';
import 'package:mini_project/provider/cart_provider.dart';
import 'package:provider/provider.dart';

void main() {
  Gemini.init(apiKey: Env.apiGemini);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AiAreaProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.dark(
            secondary: ColorConstant.foregroundColor,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
