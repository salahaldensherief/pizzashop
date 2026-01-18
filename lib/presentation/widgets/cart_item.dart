import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzashop/presentation/cubits/cart_cubit.dart';
import 'package:pizzashop/presentation/cubits/cart_state.dart';
import '../../data/models/pizza_item_model.dart';

class CartItem extends StatelessWidget {
  final PizzaItemModel pizza;

  final VoidCallback? onIncreaseQty;
  final VoidCallback? onDecreaseQty;

  const CartItem({
    super.key,
    required this.pizza,
    this.onIncreaseQty,
    this.onDecreaseQty,
  });
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pizza.icon ?? '🍕', style: const TextStyle(fontSize: 80)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pizza.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(pizza.description, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text('\$${pizza.basePrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20, color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
              width: 90,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(onTap: onIncreaseQty, child: const Icon(Icons.add, size: 18)),
                  Text(pizza.quantity.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  GestureDetector(onTap: onDecreaseQty, child:
                 pizza.quantity == 1
                      ?  Icon(Icons.delete, size: 18)
                      :  Icon(Icons.remove, size: 18),),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),

        const Text(
          "Add-ons:",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 10),

        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: pizza.options.length,
            itemBuilder: (context, index) {
              final option = pizza.options[index];

              final isSelected =
              pizza.selectOptions.any((e) => e.id == option.id);

              return GestureDetector(
                onTap: () {
                  context.read<CartCubit>().toggleOption(pizza, option);
                },
                child: Container(

                  width: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.green.withOpacity(0.3)
                        : Colors.black12,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        option.icon ?? '🍕',
                        style: const TextStyle(fontSize: 40),
                      ),
                      const SizedBox(height: 5),
                      Text(option.name),
                      const SizedBox(height: 5),
                      Text(
                        "\$${option.basePrice.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )

      ],
    );
  }
}
