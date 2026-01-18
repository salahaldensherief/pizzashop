import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/cart_state.dart';
import 'pizza_cart_screen.dart';
import 'widgets/pizza_card.dart';
import 'cubits/cart_cubit.dart';
import 'cubits/layout_cubit.dart';
import 'cubits/layout_state.dart';
class Layout extends StatelessWidget {
  const Layout({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pizza Shop"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const PizzaCartScreen()));
            },
          ),
        ],
      ),
      body: BlocBuilder<PizzaLayoutCubit, PizzaLayoutState>(
        builder: (context, layoutState) {
          if (layoutState is! PizzaLoaded) return const Center(child: CircularProgressIndicator());
          final pizzas = layoutState.pizza;

          return BlocBuilder<CartCubit, CartState>(
            builder: (context, cartState) {
              return GridView.builder(
                padding: const EdgeInsets.all(2),
                itemCount: pizzas.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final pizza = pizzas[index];
                  final cartItem = cartState.cart.items.firstWhere(
                        (item) => item.id == pizza.id,
                    orElse: () => pizza.cloneForCart(),
                  );
                  return PizzaCard(
                    pizza: cartItem,
                    quantity: cartItem.quantity,
                    onAdd: () => context.read<CartCubit>().addOrIncreasePizza(pizza),
                    onDecrease: () => context.read<CartCubit>().decreasePizzaInCart(pizza),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
