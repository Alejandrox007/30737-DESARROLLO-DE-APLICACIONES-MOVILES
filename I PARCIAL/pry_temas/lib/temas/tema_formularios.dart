import 'package:flutter/material.dart';
import 'esquema_color.dart';

class TemaFormularios {
  static final campoTexto = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white.withValues(alpha: 0.9),
    labelStyle: TextStyle(color: ColoresApp.textoOscuro.withValues(alpha: 0.6)),
    hintStyle: TextStyle(color: ColoresApp.textoOscuro.withValues(alpha: 0.4)),
    prefixIconColor: ColoresApp.primario,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: ColoresApp.primario.withValues(alpha: 0.3)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: ColoresApp.primario, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: ColoresApp.error, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: ColoresApp.error, width: 2),
    ),
  );
}