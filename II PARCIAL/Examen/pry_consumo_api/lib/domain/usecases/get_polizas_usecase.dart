import '../entities/poliza.dart';
import '../../data/repositories/poliza_repository_impl.dart';

class GetPolizasUsecase {
  final PolizaRepositoryImpl repository;

  GetPolizasUsecase(this.repository);

  Future<List<Poliza>> call() {
    return repository.getPolizas();
  }
}
