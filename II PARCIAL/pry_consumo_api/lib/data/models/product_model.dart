import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.price,
    required super.description,
    required super.category,
  });

  // convertir json a objeto (FakeStore API)
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["title"],
      imageUrl: json["image"],
      price: (json["price"] as num).toDouble(),
      description: json["description"],
      category: json["category"],
    );
  }
}
