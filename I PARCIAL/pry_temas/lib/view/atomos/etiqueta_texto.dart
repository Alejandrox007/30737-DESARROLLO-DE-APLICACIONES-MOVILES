import 'package:flutter/material.dart';

class EtiquetaTexto extends StatelessWidget {
  final String titulo;
  final String valor;

  const EtiquetaTexto({
    super.key,
    required this.titulo,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titulo,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            valor,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
