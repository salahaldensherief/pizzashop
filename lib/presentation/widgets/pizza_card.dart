import 'package:flutter/material.dart';
import '../../data/models/pizza_item_model.dart';

class PizzaCard extends StatelessWidget {
  final PizzaItemModel pizza;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback? onDecrease;

  const PizzaCard({
    super.key,
    required this.pizza,
    this.quantity = 0,
    required this.onAdd,
    this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  pizza.icon ?? '🍕',
                  style: const TextStyle(fontSize: 64),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              pizza.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              pizza.description,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${pizza.basePrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                quantity == 0
                    ? IconButton(icon: const Icon(Icons.add), onPressed: onAdd)
                    : Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add, size: 18),
                            onPressed: onAdd,
                          ),
                          Text(
                            quantity.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          IconButton(
                            icon: quantity == 1
                                ? const Icon(Icons.delete, size: 18)
                                : const Icon(Icons.remove, size: 18),
                            onPressed: onDecrease,
                          ),
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
