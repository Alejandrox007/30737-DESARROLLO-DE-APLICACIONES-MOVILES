class ServicioLavadoModelo {
  final String nombreCliente;
  final String tipoVehiculo;
  final String tipoLavado;
  final String servicioAdicional;
  final double subtotal;
  final double iva;
  final double total;

  ServicioLavadoModelo({
    required this.nombreCliente,
    required this.tipoVehiculo,
    required this.tipoLavado,
    required this.servicioAdicional,
    required this.subtotal,
    required this.iva,
    required this.total,
  });
}
