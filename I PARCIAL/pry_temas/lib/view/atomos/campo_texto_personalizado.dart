import 'package:flutter/material.dart';

class CampoTextoPersonalizado extends StatelessWidget {
  final String etiqueta;
  final IconData icono;
  final TextEditingController controlador;
  final bool ocultarTexto;

  const CampoTextoPersonalizado({
    super.key,
    required this.etiqueta,
    required this.icono,
    required this.controlador,
    this.ocultarTexto = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      obscureText: ocultarTexto,
      decoration: InputDecoration(
        labelText: etiqueta,
        prefixIcon: Icon(icono),
      ),
    );
  }
}
