class Poliza {
  final String id;
  final String codigo;
  final String cliente;
  final String tipoSeguro;
  final String fechaInicio;
  final String fechaVencimiento;
  final double valorAsegurado;

  Poliza({
    required this.id,
    required this.codigo,
    required this.cliente,
    required this.tipoSeguro,
    required this.fechaInicio,
    required this.fechaVencimiento,
    required this.valorAsegurado,
  });
}
