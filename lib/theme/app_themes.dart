import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/theme/app_colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightAccentColor,
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    cardColor: AppColors.lightCardColor,
    dividerColor: AppColors.lightDividerColor,
    shadowColor: AppColors.lightShadowColor,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: AppColors.lightTextColor,
      displayColor: AppColors.lightTextColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightBackgroundColor,
      foregroundColor: AppColors.lightTextColor,
      elevation: 0,
      centerTitle: true,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.lightAccentColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightAccentColor,
        foregroundColor: AppColors.lightTextColor, // Adjusted for monochromatic
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.lightAccentColor,
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.lightTextColor),
    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.lightAccentColor,
      unselectedLabelColor: AppColors.lightTextColor.withOpacity(0.6),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.lightAccentColor, width: 2.0),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkAccentColor,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    cardColor: AppColors.darkCardColor,
    dividerColor: AppColors.darkDividerColor,
    shadowColor: AppColors.darkShadowColor,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: AppColors.darkTextColor,
      displayColor: AppColors.darkTextColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackgroundColor,
      foregroundColor: AppColors.darkTextColor,
      elevation: 0,
      centerTitle: true,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.darkAccentColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkAccentColor,
        foregroundColor: AppColors.darkBackgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.darkAccentColor,
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.darkTextColor),
    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.darkAccentColor,
      unselectedLabelColor: AppColors.darkTextColor.withOpacity(0.6),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.darkAccentColor, width: 2.0),
      ),
    ),
  );
}
