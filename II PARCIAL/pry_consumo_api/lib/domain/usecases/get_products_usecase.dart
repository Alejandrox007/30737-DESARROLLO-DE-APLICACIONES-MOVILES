import '../entities/product.dart';
import '../../data/repositories/product_repository_impl.dart';

class GetProductsUsecase {
  final ProductRepositoryImpl repository;

  GetProductsUsecase(this.repository);

  Future<List<Product>> call() {
    return repository.getProducts(limit: 30, offset: 0);
  }
}
