import '../../domain/entities/product.dart';
import '../datasource/fakestore_datasource.dart';


class ProductRepositoryImpl {
  //instanciamos
  final FakestoreDatasource datasource;
  ProductRepositoryImpl(this.datasource);

  Future<List<Product>> getProducts({int limit = 30, int offset = 0}) async {
    return datasource.fetchProducts(limit, offset);
  }

}
