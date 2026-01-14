import 'package:meta/meta.dart';
import 'package:pizzashop/data/models/cart_model.dart';
import 'package:pizzashop/data/models/pizza_item_model.dart';

@immutable
class CartState {
  final CartModel cart;
  final PizzaItemModel pizza;


  const CartState({
    required this.cart,
    required this.pizza,
  });

  CartState copyWith({
    CartModel? cart,
    PizzaItemModel? pizza,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      pizza: pizza ?? this.pizza,
    );
  }
}
