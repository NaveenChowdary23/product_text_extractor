import 'package:flutter/material.dart';
import 'services/text_extractor_service.dart';
import 'widgets/product_view.dart';
import 'models/product_info.dart';

class ProductTextExtractor {
  final TextExtractorService _service = TextExtractorService();

  Future<ProductInfo?> extractProductInfo() async {
    return await _service.extractProductInfo();
  }

  Widget buildProductView({
    required ProductInfo product,
    required VoidCallback onRetake,
    required VoidCallback onSave,
  }) {
    return ProductView(
      product: product,
      onRetake: onRetake,
      onSave: onSave,
    );
  }
}