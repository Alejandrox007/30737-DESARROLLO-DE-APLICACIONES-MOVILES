import 'package:flutter/material.dart';
import '../atomos/campo_texto_personalizado.dart';
import '../atomos/selector_personalizado.dart';
import '../atomos/boton_personalizado.dart';

class FormularioLavado extends StatelessWidget {
  final TextEditingController clienteCtrl;
  final String? vehiculoSeleccionado;
  final String? lavadoSeleccionado;
  final String? adicionalSeleccionado;
  final ValueChanged<String?> alCambiarVehiculo;
  final ValueChanged<String?> alCambiarLavado;
  final ValueChanged<String?> alCambiarAdicional;
  final VoidCallback alEnviar;

  const FormularioLavado({
    super.key,
    required this.clienteCtrl,
    required this.vehiculoSeleccionado,
    required this.lavadoSeleccionado,
    required this.adicionalSeleccionado,
    required this.alCambiarVehiculo,
    required this.alCambiarLavado,
    required this.alCambiarAdicional,
    required this.alEnviar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.local_car_wash, size: 100, color: Colors.white),
        const SizedBox(height: 10),
        const Text(
          'Lavadora de Autos ESPE',
          style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        CampoTextoPersonalizado(
          etiqueta: 'Ingrese su nombre completo',
          icono: Icons.person,
          controlador: clienteCtrl,
        ),
        const SizedBox(height: 16),
        SelectorPersonalizado(
          etiqueta: 'Tipo de vehículo',
          icono: Icons.directions_car,
          opciones: const ['Auto', 'Camioneta', 'Moto'],
          valorSeleccionado: vehiculoSeleccionado,
          alCambiar: alCambiarVehiculo,
        ),
        const SizedBox(height: 16),
        SelectorPersonalizado(
          etiqueta: 'Tipo de lavado',
          icono: Icons.cleaning_services,
          opciones: const ['Básico', 'Completo', 'Premium'],
          valorSeleccionado: lavadoSeleccionado,
          alCambiar: alCambiarLavado,
        ),
        const SizedBox(height: 16),
        SelectorPersonalizado(
          etiqueta: 'Servicio adicional',
          icono: Icons.add_circle_outline,
          opciones: const ['Ninguno', 'Encerado', 'Aspirado'],
          valorSeleccionado: adicionalSeleccionado,
          alCambiar: alCambiarAdicional,
        ),
        const SizedBox(height: 20),
        BotonPersonalizado(
          texto: 'Generar Nota de Venta',
          alPresionar: alEnviar,
        ),
      ],
    );
  }
}
