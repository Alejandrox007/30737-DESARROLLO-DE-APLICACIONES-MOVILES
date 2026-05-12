import 'package:flutter/material.dart';
import 'temas/index.dart';
import 'view/paginas/vista_lavado.dart';
import 'view/paginas/vista_nota_venta.dart';

void main() {
  runApp(const AplicacionBase());
}

class AplicacionBase extends StatelessWidget {
  const AplicacionBase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lavadora de Autos',
      theme: TemaGeneral.claro,
      initialRoute: '/lavado',
      routes: {
        '/lavado': (context) => const VistaLavado(),
        '/notaVenta': (context) => const VistaNotaVenta(),
      },
    );
  }
}
