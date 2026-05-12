import 'package:flutter/material.dart';
import '../../model/servicio_lavado_modelo.dart';
import '../moleculas/bloque_nota_venta.dart';
import '../../temas/index.dart';

class VistaNotaVenta extends StatelessWidget {
  const VistaNotaVenta({super.key});

  @override
  Widget build(BuildContext context) {
    final servicio = ModalRoute.of(context)!.settings.arguments as ServicioLavadoModelo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nota de Venta'),
      ),
      body: Container(
        decoration: FondoApp.fondoGris,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BloqueNotaVenta(servicio: servicio),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Volver'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
