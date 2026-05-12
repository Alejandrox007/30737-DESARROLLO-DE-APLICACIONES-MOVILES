import 'package:flutter/material.dart';

class SelectorPersonalizado extends StatelessWidget {
  final String etiqueta;
  final IconData icono;
  final List<String> opciones;
  final String? valorSeleccionado;
  final ValueChanged<String?> alCambiar;

  const SelectorPersonalizado({
    super.key,
    required this.etiqueta,
    required this.icono,
    required this.opciones,
    required this.valorSeleccionado,
    required this.alCambiar,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: valorSeleccionado,
      decoration: InputDecoration(
        labelText: etiqueta,
        prefixIcon: Icon(icono),
      ),
      items: opciones.map((String opcion) {
        return DropdownMenuItem<String>(
          value: opcion,
          child: Text(opcion),
        );
      }).toList(),
      onChanged: alCambiar,
    );
  }
}
