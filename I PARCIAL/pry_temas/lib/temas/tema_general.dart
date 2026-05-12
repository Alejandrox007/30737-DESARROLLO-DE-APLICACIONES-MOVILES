import 'package:flutter/material.dart';
import 'esquema_color.dart';
import 'tema_botones.dart';
import 'tipografia.dart';
import 'tema_appbar.dart';
import 'tema_formularios.dart';

class TemaGeneral {
  static ThemeData claro = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: ColoresApp.primario,
      secondary: ColoresApp.secundario,
      surface: ColoresApp.fondo,
      onPrimary: ColoresApp.textoClaro,
      onSecondary: ColoresApp.textoClaro,
    ),
    textTheme: Tipografia.tema,
    appBarTheme: TemaAppbar.tema,
    elevatedButtonTheme: TemaBotones.botonPrincipal,
    outlinedButtonTheme: TemaBotones.botonSecundario,
    inputDecorationTheme: TemaFormularios.campoTexto,
    scaffoldBackgroundColor: ColoresApp.fondo,
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 5,
      shadowColor: ColoresApp.primario.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.all(16),
    ),
    dividerTheme: DividerThemeData(
      color: ColoresApp.primario.withValues(alpha: 0.2),
      thickness: 1,
      space: 24,
    ),
  );
  
}