import 'package:flutter/material.dart';
import '../../domain/entities/poliza.dart';
import '../../domain/usecases/get_polizas_usecase.dart';
import '../../domain/usecases/create_poliza_usecase.dart';
import '../../domain/usecases/update_poliza_usecase.dart';
import '../../domain/usecases/delete_poliza_usecase.dart';

class PolizaViewModel extends ChangeNotifier {
  final GetPolizasUsecase getPolizasUsecase;
  final CreatePolizaUsecase createPolizaUsecase;
  final UpdatePolizaUsecase updatePolizaUsecase;
  final DeletePolizaUsecase deletePolizaUsecase;

  PolizaViewModel({
    required this.getPolizasUsecase,
    required this.createPolizaUsecase,
    required this.updatePolizaUsecase,
    required this.deletePolizaUsecase,
  });

  List<Poliza> polizas = [];
  bool loading = false;
  String? errorMessage;

  Future<void> loadPolizas() async {
    loading = true;
    errorMessage = null;
    notifyListeners();
    try {
      polizas = await getPolizasUsecase();
    } catch (e) {
      errorMessage = "Error al cargar las pólizas";
    }
    loading = false;
    notifyListeners();
  }

  Future<bool> createPoliza(Poliza poliza) async {
    loading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final newPoliza = await createPolizaUsecase(poliza);
      polizas.add(newPoliza);
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = "Error al crear la póliza";
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updatePoliza(Poliza poliza) async {
    loading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final updated = await updatePolizaUsecase(poliza);
      final index = polizas.indexWhere((p) => p.id == poliza.id);
      if (index != -1) {
        polizas[index] = updated;
      }
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = "Error al actualizar la póliza";
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deletePoliza(String id) async {
    loading = true;
    errorMessage = null;
    notifyListeners();
    try {
      await deletePolizaUsecase(id);
      polizas.removeWhere((p) => p.id == id);
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = "Error al eliminar la póliza";
      loading = false;
      notifyListeners();
      return false;
    }
  }
}
