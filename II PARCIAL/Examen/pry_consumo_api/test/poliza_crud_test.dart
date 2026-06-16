import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:pry_consumo_api/data/datasource/poliza_api_datasource.dart';
import 'package:pry_consumo_api/data/repositories/poliza_repository_impl.dart';
import 'package:pry_consumo_api/domain/entities/poliza.dart';
import 'package:pry_consumo_api/domain/usecases/get_polizas_usecase.dart';
import 'package:pry_consumo_api/domain/usecases/create_poliza_usecase.dart';
import 'package:pry_consumo_api/domain/usecases/update_poliza_usecase.dart';
import 'package:pry_consumo_api/domain/usecases/delete_poliza_usecase.dart';

void main() {
  Process? backendProcess;

  setUpAll(() async {
    // Iniciar servidor FastAPI corriendo en Python
    backendProcess = await Process.start('python', ['backend/main.py']);
    // Esperar un momento para dar tiempo al servidor de levantarse
    await Future.delayed(const Duration(seconds: 3));
  });

  tearDownAll(() async {
    // Finalizar proceso del backend
    backendProcess?.kill();
  });

  test('Debería realizar todas las operaciones CRUD (Get, Create, Update, Delete) consumiendo la API REST', () async {
    final datasource = PolizaApiDatasource();
    final repository = PolizaRepositoryImpl(datasource);

    final getUsecase = GetPolizasUsecase(repository);
    final createUsecase = CreatePolizaUsecase(repository);
    final updateUsecase = UpdatePolizaUsecase(repository);
    final deleteUsecase = DeletePolizaUsecase(repository);

    // 1. READ: Obtener pólizas iniciales
    final initialList = await getUsecase();
    expect(initialList.length, 2);
    expect(initialList[0].cliente, "Alejandro Gomez");
    expect(initialList[1].cliente, "Maria Lopez");

    // 2. CREATE: Registrar una nueva póliza
    final nueva = Poliza(
      id: "",
      codigo: "POL-TEST-999",
      cliente: "Test Persona",
      tipoSeguro: "Salud",
      fechaInicio: "2026-06-01",
      fechaVencimiento: "2027-06-01",
      valorAsegurado: 75000.0,
    );
    
    final creada = await createUsecase(nueva);
    expect(creada.id.isNotEmpty, true);
    expect(creada.codigo, "POL-TEST-999");
    expect(creada.cliente, "Test Persona");
    expect(creada.tipoSeguro, "Salud");
    expect(creada.valorAsegurado, 75000.0);

    // Verificar incremento en la lista
    final listAfterCreate = await getUsecase();
    expect(listAfterCreate.length, 3);

    // 3. UPDATE: Actualizar la póliza creada
    final actualizable = Poliza(
      id: creada.id,
      codigo: creada.codigo,
      cliente: "Test Persona Modificado",
      tipoSeguro: creada.tipoSeguro,
      fechaInicio: creada.fechaInicio,
      fechaVencimiento: creada.fechaVencimiento,
      valorAsegurado: 80000.0,
    );
    
    final actualizada = await updateUsecase(actualizable);
    expect(actualizada.id, creada.id);
    expect(actualizada.cliente, "Test Persona Modificado");
    expect(actualizada.valorAsegurado, 80000.0);

    // 4. DELETE: Eliminar la póliza registrada
    await deleteUsecase(creada.id);

    // Verificar que vuelve a tener 2 pólizas
    final finalList = await getUsecase();
    expect(finalList.length, 2);
    expect(finalList.any((p) => p.id == creada.id), false);
  });
}
