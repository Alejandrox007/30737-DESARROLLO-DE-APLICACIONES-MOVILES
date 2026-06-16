import '../../data/repositories/poliza_repository_impl.dart';

class DeletePolizaUsecase {
  final PolizaRepositoryImpl repository;

  DeletePolizaUsecase(this.repository);

  Future<void> call(String id) {
    return repository.deletePoliza(id);
  }
}
