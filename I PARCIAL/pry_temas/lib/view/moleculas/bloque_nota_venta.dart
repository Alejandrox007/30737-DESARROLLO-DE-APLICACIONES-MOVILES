import 'package:flutter/material.dart';
import '../../model/servicio_lavado_modelo.dart';
import '../atomos/etiqueta_texto.dart';

class BloqueNotaVenta extends StatelessWidget {
  final ServicioLavadoModelo servicio;

  const BloqueNotaVenta({
    super.key,
    required this.servicio,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'NOTA DE VENTA',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 8),
            EtiquetaTexto(titulo: 'Cliente:', valor: servicio.nombreCliente),
            EtiquetaTexto(titulo: 'Vehículo:', valor: servicio.tipoVehiculo),
            EtiquetaTexto(titulo: 'Lavado:', valor: servicio.tipoLavado),
            EtiquetaTexto(titulo: 'Servicio Adicional:', valor: servicio.servicioAdicional),
            const Divider(),
            const SizedBox(height: 8),
            EtiquetaTexto(titulo: 'Subtotal:', valor: '\$${servicio.subtotal.toStringAsFixed(2)}'),
            EtiquetaTexto(titulo: 'IVA (15%):', valor: '\$${servicio.iva.toStringAsFixed(2)}'),
            const Divider(thickness: 2),
            EtiquetaTexto(titulo: 'TOTAL:', valor: '\$${servicio.total.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
