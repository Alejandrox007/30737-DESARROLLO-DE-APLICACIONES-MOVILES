import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

class FakestoreDatasource {
  final String baseUrl = "https://fakestoreapi.com/products";

  Future<List<ProductModel>> fetchProducts(int limit, int offset) async {
    final url = Uri.parse("$baseUrl?limit=$limit");

    final resp = await http.get(url);

    if (resp.statusCode != 200) {
      throw Exception("Error al cargar productos");
    }
    // FakeStore devuelve directamente un array JSON (no un objeto con "results")
    final List data = jsonDecode(resp.body);

    return data.map((e) => ProductModel.fromJson(e)).toList();
  }
}
