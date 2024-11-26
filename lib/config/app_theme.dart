import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stylers_in_customer/config/size_config.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';

import 'app_colors.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.pink,
    primaryColor: AppColors.kPrimaryColor,
    // backgroundColor: AppColors.appBackgroundColor,
    scaffoldBackgroundColor: Colors.white,
    //fontFamily: "Muli",
    appBarTheme: appBarTheme(),
    buttonTheme: _buttonThemeData(),
    fontFamily: 'Quicksand',
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(context),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme(BuildContext context) {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: AppColors.textColorPrimary),
    gapPadding: 10,
  );
  OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: AppColors.kPrimaryColor),
    gapPadding: 10,
  );

  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    contentPadding: EdgeInsets.symmetric(
        horizontal: 2 * SizeConfig.widthMultiplier,
        vertical: 2 * SizeConfig.heightMultiplier),
    enabledBorder: outlineInputBorder,
    focusedBorder: enabledBorder,
    hintStyle: Theme.of(context).textTheme.bodyMedium,
    labelStyle: Theme.of(context).textTheme.bodyMedium,
    errorStyle:
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.red),
    border: outlineInputBorder,
    /*   errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.red, width: .5),
    )*/
  );
}

TextTheme textTheme() {
  return TextTheme(
    //headlineLarge
    headlineLarge: TextStyle(
        color: AppColors.textColorPrimary,
        fontSize: AppConsts.commonFontSizeFactor * 34,
        fontWeight: FontWeight.w500,
        fontFamily: 'ibmPlexSans'),
    //headlineLarge
    // headline2: TextStyle(
    //     color: Colors.white,
    //     fontSize: AppConsts.commonFontSizeFactor * 28,
    //     fontWeight: FontWeight.w500,
    //     fontFamily: 'ibmPlexSans'),
    //headlineLarge
    headlineMedium: TextStyle(
        color: AppColors.textColorPrimary,
        fontSize: AppConsts.commonFontSizeFactor * 22,
        fontWeight: FontWeight.w500,
        fontFamily: 'ibmPlexSans'),

    // headline4: TextStyle(
    //     color: AppColors.textColorPrimary,
    //     fontSize: AppConsts.commonFontSizeFactor * 18,
    //     fontWeight: FontWeight.w500,
    //     fontFamily: 'ibmPlexSans'),

    headlineSmall: TextStyle(
        color: AppColors.textColorPrimary,
        fontSize: AppConsts.commonFontSizeFactor * 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'ibmPlexSans'),

    // headline6: TextStyle(
    //     color: AppColors.textColorPrimary,
    //     fontSize: AppConsts.commonFontSizeFactor * 12,
    //     fontWeight: FontWeight.w500,
    //     fontFamily: 'ibmPlexSans'),

    // subtitle1: TextStyle(
    //     color: AppColors.textColorPrimary,
    //     fontSize: AppConsts.commonFontSizeFactor * 14,
    //     fontWeight: FontWeight.w300,
    //     fontFamily: 'ibmPlexSans'),
    bodyLarge:
        TextStyle(color: AppColors.textColorPrimary, fontFamily: 'ibmPlexSans'),
    bodyMedium:
        TextStyle(color: AppColors.textColorPrimary, fontFamily: 'ibmPlexSans'),
    bodySmall:
        TextStyle(color: AppColors.textColorPrimary, fontFamily: 'ibmPlexSans'),
    // button: TextStyle(
    //   color: Colors.white,
    //   fontWeight: FontWeight.w600,
    //   fontSize: AppConsts.commonFontSizeFactor * 13,
    //   fontFamily: 'ibmPlexSans',
    // ),
  );
}

ButtonThemeData _buttonThemeData() {
  return ButtonThemeData(
    buttonColor: AppColors.kPrimaryColor,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
      color: AppColors.appBarColor,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark
          .copyWith(statusBarColor: Colors.transparent),
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: const TextStyle(
          color: Colors.black,
          fontFamily: 'ibmPlexSans',
          fontWeight: FontWeight.w500,
          fontSize: 16.0));
}
