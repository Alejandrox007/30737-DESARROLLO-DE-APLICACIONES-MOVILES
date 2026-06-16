import 'package:flutter_test/flutter_test.dart';
import 'package:pry_consumo_api/domain/entities/poliza.dart';
import 'package:pry_consumo_api/data/repositories/poliza_repository_impl.dart';
import 'package:pry_consumo_api/data/datasource/poliza_api_datasource.dart';
import 'package:pry_consumo_api/domain/usecases/get_polizas_usecase.dart';
import 'package:pry_consumo_api/domain/usecases/create_poliza_usecase.dart';
import 'package:pry_consumo_api/domain/usecases/update_poliza_usecase.dart';
import 'package:pry_consumo_api/domain/usecases/delete_poliza_usecase.dart';
import 'package:pry_consumo_api/main.dart';

class MockPolizaRepository extends PolizaRepositoryImpl {
  MockPolizaRepository() : super(PolizaApiDatasource());

  @override
  Future<List<Poliza>> getPolizas() async {
    return [
      Poliza(
        id: "1",
        codigo: "POL-001",
        cliente: "Cliente Mock",
        tipoSeguro: "Vida",
        fechaInicio: "2026-01-01",
        fechaVencimiento: "2027-01-01",
        valorAsegurado: 100000.0,
      )
    ];
  }

  @override
  Future<Poliza> createPoliza(Poliza poliza) async {
    return poliza;
  }

  @override
  Future<Poliza> updatePoliza(Poliza poliza) async {
    return poliza;
  }

  @override
  Future<void> deletePoliza(String id) async {}
}

void main() {
  testWidgets('Smoke test de inicialización de la App', (WidgetTester tester) async {
    final mockRepository = MockPolizaRepository();
    
    final getUsecase = GetPolizasUsecase(mockRepository);
    final createUsecase = CreatePolizaUsecase(mockRepository);
    final updateUsecase = UpdatePolizaUsecase(mockRepository);
    final deleteUsecase = DeletePolizaUsecase(mockRepository);

    await tester.pumpWidget(MyApp(
      getUsecase: getUsecase,
      createUsecase: createUsecase,
      updateUsecase: updateUsecase,
      deleteUsecase: deleteUsecase,
    ));

    // Procesar el microtask asíncrono para la carga de datos inicial
    await tester.pump();

    // Verificar que el widget principal se renderiza
    expect(find.byType(MyApp), findsOneWidget);
    
    // Verificar que se visualiza el título
    expect(find.text("Pólizas de Seguro"), findsOneWidget);

    // Verificar que el listado muestra los datos cargados por el mock
    expect(find.text("Cliente Mock"), findsOneWidget);
  });
}
