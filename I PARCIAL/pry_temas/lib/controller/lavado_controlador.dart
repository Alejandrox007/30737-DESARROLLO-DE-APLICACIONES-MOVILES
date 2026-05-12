import '../model/servicio_lavado_modelo.dart';

class LavadoControlador {
  String? validar(String nombre, String? vehiculo, String? lavado) {
    if (nombre.isEmpty) {
      return 'Ingrese el nombre del cliente';
    }
    if (vehiculo == null) {
      return 'Seleccione el tipo de vehículo';
    }
    if (lavado == null) {
      return 'Seleccione el tipo de lavado';
    }
    return null;
  }

  double obtenerPrecioBase(String tipoVehiculo, String tipoLavado) {
    final Map<String, Map<String, double>> precios = {
      'Auto': {'Básico': 5.00, 'Completo': 10.00, 'Premium': 18.00},
      'Camioneta': {'Básico': 8.00, 'Completo': 15.00, 'Premium': 25.00},
      'Moto': {'Básico': 3.00, 'Completo': 6.00, 'Premium': 10.00},
    };
    return precios[tipoVehiculo]?[tipoLavado] ?? 0.0;
  }

  double obtenerPrecioAdicional(String servicioAdicional) {
    final Map<String, double> adicionales = {
      'Ninguno': 0.00,
      'Encerado': 5.00,
      'Aspirado': 4.00,
    };
    return adicionales[servicioAdicional] ?? 0.0;
  }

  double calcularSubtotal(double precioBase, double precioAdicional) {
    return precioBase + precioAdicional;
  }

  double calcularIva(double subtotal) {
    return subtotal * 0.15;
  }

  double calcularTotal(double subtotal, double iva) {
    return subtotal + iva;
  }

  ServicioLavadoModelo generarNota({
    required String nombreCliente,
    required String tipoVehiculo,
    required String tipoLavado,
    required String servicioAdicional,
  }) {
    final precioBase = obtenerPrecioBase(tipoVehiculo, tipoLavado);
    final precioAdicional = obtenerPrecioAdicional(servicioAdicional);
    final subtotal = calcularSubtotal(precioBase, precioAdicional);
    final iva = calcularIva(subtotal);
    final total = calcularTotal(subtotal, iva);

    return ServicioLavadoModelo(
      nombreCliente: nombreCliente,
      tipoVehiculo: tipoVehiculo,
      tipoLavado: tipoLavado,
      servicioAdicional: servicioAdicional,
      subtotal: subtotal,
      iva: iva,
      total: total,
    );
  }
}
