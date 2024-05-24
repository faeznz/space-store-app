import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/constant/color_constant.dart';

class TextStyleConstant {
  static TextStyle bebasNeueBold = GoogleFonts.bebasNeue(
    fontSize: 24,
    color: ColorConstant.foregroundColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle ibmPlexSans = GoogleFonts.ibmPlexSans(
    fontSize: 16,
    color: ColorConstant.foregroundColor,
    fontWeight: FontWeight.normal,
  );
}
