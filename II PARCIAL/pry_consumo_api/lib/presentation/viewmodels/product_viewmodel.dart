import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products_usecase.dart';

class ProductViewModel extends ChangeNotifier {

  final GetProductsUsecase getProductsUsecase;

  ProductViewModel(this.getProductsUsecase);

  //manejo de estado
  List<Product> products = [];
  bool loading = false;
  String? errorMessage;

  Future<void> loadProducts() async {
    loading = true;
    notifyListeners();
    try {
      products = await getProductsUsecase();
    } catch (e) {
      errorMessage = "Error al cargar los productos";
    }
    loading = false;
    notifyListeners();
  }

}
