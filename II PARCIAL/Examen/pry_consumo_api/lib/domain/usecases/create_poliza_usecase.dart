import '../entities/poliza.dart';
import '../../data/repositories/poliza_repository_impl.dart';

class CreatePolizaUsecase {
  final PolizaRepositoryImpl repository;

  CreatePolizaUsecase(this.repository);

  Future<Poliza> call(Poliza poliza) {
    return repository.createPoliza(poliza);
  }
}
