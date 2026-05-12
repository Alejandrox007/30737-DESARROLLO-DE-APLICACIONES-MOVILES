import 'package:flutter/material.dart';

class BotonPersonalizado extends StatelessWidget {
  final String texto;
  final VoidCallback alPresionar;

  const BotonPersonalizado({
    super.key,
    required this.texto,
    required this.alPresionar,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: alPresionar,
      child: Text(
        texto,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
