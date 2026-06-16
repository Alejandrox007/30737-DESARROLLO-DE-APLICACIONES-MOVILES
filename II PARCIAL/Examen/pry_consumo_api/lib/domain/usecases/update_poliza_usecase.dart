import '../entities/poliza.dart';
import '../../data/repositories/poliza_repository_impl.dart';

class UpdatePolizaUsecase {
  final PolizaRepositoryImpl repository;

  UpdatePolizaUsecase(this.repository);

  Future<Poliza> call(Poliza poliza) {
    return repository.updatePoliza(poliza);
  }
}
