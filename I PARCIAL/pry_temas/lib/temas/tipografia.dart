import 'package:flutter/material.dart';
import 'esquema_color.dart';

class Tipografia {
  static final TextTheme tema = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32, 
      fontWeight: FontWeight.bold, 
      color: ColoresApp.textoOscuro,
      letterSpacing: -0.5,
    ),
    titleLarge: TextStyle(
      fontSize: 24, 
      fontWeight: FontWeight.w800, 
      color: ColoresApp.primario,
      letterSpacing: 0.5,
    ),
    titleMedium: TextStyle(
      fontSize: 18, 
      fontWeight: FontWeight.w600, 
      color: ColoresApp.textoOscuro,
    ),
    bodyLarge: TextStyle(
      fontSize: 16, 
      fontWeight: FontWeight.normal, 
      color: ColoresApp.textoOscuro,
    ),
    bodyMedium: TextStyle(
      fontSize: 14, 
      fontWeight: FontWeight.normal, 
      color: ColoresApp.textoOscuro.withValues(alpha: 0.8),
    ),
    labelLarge: TextStyle(
      fontSize: 14, 
      fontWeight: FontWeight.bold, 
      color: ColoresApp.primario,
    ),
  );
}
