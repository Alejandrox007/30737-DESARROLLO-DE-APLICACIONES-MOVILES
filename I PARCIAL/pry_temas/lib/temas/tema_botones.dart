import 'package:flutter/material.dart';
import 'esquema_color.dart';

class TemaBotones {
  static final botonPrincipal = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColoresApp.primario,
        foregroundColor: ColoresApp.textoClaro,
        elevation: 4,
        shadowColor: ColoresApp.primario.withValues(alpha: 0.4),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        textStyle: TextStyle(
          fontWeight: FontWeight.bold, 
          fontSize: 16,
          letterSpacing: 1.1,
        ),
      )
  );

  // Boton secundario
  static final botonSecundario = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ColoresApp.primario,
      side: BorderSide(color: ColoresApp.primario, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    )
  );
}