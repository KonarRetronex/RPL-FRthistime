import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

ThemeData buildAppTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      background: AppColors.background,
    ),
    fontFamily: GoogleFonts.poppins().fontFamily,
    
    // appBarTheme TIDAK bisa const karena titleTextStyle
    appBarTheme: AppBarTheme( 
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        color: AppColors.textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: AppColors.textPrimary), // Ini BOLEH const
    ),
    
    // cardTheme BISA const
  // cardTheme BISA const
   // cardTheme BISA const
    cardTheme: CardThemeData( // <-- Biarkan const di LUAR ini
      elevation: 0,
      color: AppColors.card,
      
      // Hapus 'const' dari sini
      shape: RoundedRectangleBorder( 
        
        // Hapus 'const' dari sini juga
        borderRadius: BorderRadius.circular(16.0), 
      ),
    ), // CardThemeData
    
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    
    // bottomNavigationBarTheme TIDAK bisa const karena unselectedItemColor
    bottomNavigationBarTheme: BottomNavigationBarThemeData( 
      backgroundColor: AppColors.card,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary.withOpacity(0.7), // Ini tidak const
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),
    
    // textTheme TIDAK bisa const karena GoogleFonts
    textTheme: TextTheme( 
      displayLarge: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 32, color: AppColors.textPrimary),
      headlineMedium: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20, color: AppColors.textPrimary),
      bodyMedium: GoogleFonts.poppins(fontSize: 14, color: AppColors.textPrimary),
      labelMedium: GoogleFonts.poppins(fontSize: 12, color: AppColors.textPrimary),
    ),
  );
}