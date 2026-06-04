import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class DetallePage extends StatelessWidget {
  DetallePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(product.imageUrl, height: 200, fit: BoxFit.contain),
            const SizedBox(height: 16),
            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 8),
            Text(
              product.category.toUpperCase(),
              style: const TextStyle(fontSize: 13, color: Colors.grey, letterSpacing: 1.2),
            ),
            const SizedBox(height: 16),
            Text(
              product.description,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

}