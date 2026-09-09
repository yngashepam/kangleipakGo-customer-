import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductCard({super.key, required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Text(product.emoji, style: const TextStyle(fontSize: 54)),
              ),
            ),
            Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(product.unit, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: Text('₹${product.price.toStringAsFixed(0)}',
                    style: const TextStyle(fontWeight: FontWeight.w800))),
                FilledButton.tonal(onPressed: onAdd, child: const Text('ADD')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
