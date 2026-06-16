import '../../domain/entities/poliza.dart';

class PolizaModel extends Poliza {
  PolizaModel({
    required super.id,
    required super.codigo,
    required super.cliente,
    required super.tipoSeguro,
    required super.fechaInicio,
    required super.fechaVencimiento,
    required super.valorAsegurado,
  });

  factory PolizaModel.fromJson(Map<String, dynamic> json) {
    return PolizaModel(
      id: json['id']?.toString() ?? '',
      codigo: json['codigo'] ?? '',
      cliente: json['cliente'] ?? '',
      tipoSeguro: json['tipoSeguro'] ?? '',
      fechaInicio: json['fechaInicio'] ?? '',
      fechaVencimiento: json['fechaVencimiento'] ?? '',
      valorAsegurado: (json['valorAsegurado'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codigo': codigo,
      'cliente': cliente,
      'tipoSeguro': tipoSeguro,
      'fechaInicio': fechaInicio,
      'fechaVencimiento': fechaVencimiento,
      'valorAsegurado': valorAsegurado,
    };
  }
}
