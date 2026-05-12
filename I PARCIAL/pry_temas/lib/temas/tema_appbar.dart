import 'package:flutter/material.dart';
import 'esquema_color.dart';

class TemaAppbar {

  static const AppBarTheme tema = AppBarTheme(
    backgroundColor: ColoresApp.primario,
    foregroundColor: ColoresApp.textoClaro,
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 2,
    titleTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.2,
      color: ColoresApp.textoClaro,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    ),
  );

}