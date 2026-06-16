import '../../domain/entities/poliza.dart';
import '../datasource/poliza_api_datasource.dart';
import '../models/poliza_model.dart';

class PolizaRepositoryImpl {
  final PolizaApiDatasource datasource;
  PolizaRepositoryImpl(this.datasource);

  Future<List<Poliza>> getPolizas() async {
    return datasource.getPolizas();
  }

  Future<Poliza> createPoliza(Poliza poliza) async {
    final model = PolizaModel(
      id: poliza.id,
      codigo: poliza.codigo,
      cliente: poliza.cliente,
      tipoSeguro: poliza.tipoSeguro,
      fechaInicio: poliza.fechaInicio,
      fechaVencimiento: poliza.fechaVencimiento,
      valorAsegurado: poliza.valorAsegurado,
    );
    return datasource.createPoliza(model);
  }

  Future<Poliza> updatePoliza(Poliza poliza) async {
    final model = PolizaModel(
      id: poliza.id,
      codigo: poliza.codigo,
      cliente: poliza.cliente,
      tipoSeguro: poliza.tipoSeguro,
      fechaInicio: poliza.fechaInicio,
      fechaVencimiento: poliza.fechaVencimiento,
      valorAsegurado: poliza.valorAsegurado,
    );
    return datasource.updatePoliza(model);
  }

  Future<void> deletePoliza(String id) async {
    return datasource.deletePoliza(id);
  }
}
