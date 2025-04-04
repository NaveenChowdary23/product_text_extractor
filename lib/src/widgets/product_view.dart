import 'package:flutter/material.dart';
import '../models/product_info.dart';
import 'dart:io';

class ProductView extends StatelessWidget {
  final ProductInfo product;
  final VoidCallback onRetake;
  final VoidCallback onSave;

  const ProductView({
  super.key,  // Changed from Key? key
  required this.product,
  required this.onRetake,
  required this.onSave,
});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (product.imagePath != null)
          Image.file(File(product.imagePath!), height: 200),
        _buildInfoRow('Name', product.name),
        _buildInfoRow('Manufacture Date', 
          product.manufactureDate?.toString() ?? 'Not detected'),
        _buildInfoRow('Expiry Date', 
          product.expiryDate?.toString() ?? 'Not detected'),
        if (product.extractedText != null)
          ExpansionTile(
            title: Text('Extracted Text'),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(product.extractedText!),
              ),
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: onRetake,
              child: Text('Retake'),
            ),
            ElevatedButton(
              onPressed: onSave,
              child: Text('Save'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}