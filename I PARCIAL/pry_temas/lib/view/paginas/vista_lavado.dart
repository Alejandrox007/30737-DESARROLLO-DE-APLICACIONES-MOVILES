import 'package:flutter/material.dart';
import '../../controller/lavado_controlador.dart';
import '../moleculas/formulario_lavado.dart';
import '../../temas/index.dart';

class VistaLavado extends StatefulWidget {
  const VistaLavado({super.key});

  @override
  State<VistaLavado> createState() => _VistaLavadoEstado();
}

class _VistaLavadoEstado extends State<VistaLavado> {
  final clienteCtrl = TextEditingController();
  final controlador = LavadoControlador();

  String? vehiculoSeleccionado;
  String? lavadoSeleccionado;
  String? adicionalSeleccionado = 'Ninguno';

  void _generarNota() {
    final error = controlador.validar(
      clienteCtrl.text.trim(),
      vehiculoSeleccionado,
      lavadoSeleccionado,
    );

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return;
    }

    final nota = controlador.generarNota(
      nombreCliente: clienteCtrl.text.trim(),
      tipoVehiculo: vehiculoSeleccionado!,
      tipoLavado: lavadoSeleccionado!,
      servicioAdicional: adicionalSeleccionado ?? 'Ninguno',
    );

    Navigator.pushNamed(
      context,
      '/notaVenta',
      arguments: nota,
    );

    // Limpiar el formulario después de navegar
    setState(() {
      clienteCtrl.clear();
      vehiculoSeleccionado = null;
      lavadoSeleccionado = null;
      adicionalSeleccionado = 'Ninguno';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: FondoApp.degradadoPrincipal,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: FormularioLavado(
              clienteCtrl: clienteCtrl,
              vehiculoSeleccionado: vehiculoSeleccionado,
              lavadoSeleccionado: lavadoSeleccionado,
              adicionalSeleccionado: adicionalSeleccionado,
              alCambiarVehiculo: (valor) {
                setState(() => vehiculoSeleccionado = valor);
              },
              alCambiarLavado: (valor) {
                setState(() => lavadoSeleccionado = valor);
              },
              alCambiarAdicional: (valor) {
                setState(() => adicionalSeleccionado = valor);
              },
              alEnviar: _generarNota,
            ),
          ),
        ),
      ),
    );
  }
}
