import 'package:bloc/bloc.dart';
import 'package:pizzashop/data/models/cart_model.dart';
import 'package:pizzashop/data/models/pizza_item_model.dart';

import 'cart_state.dart';

enum DiscountType { percent, fixed, none }

class CartCubit extends Cubit<CartState> {
  CartCubit({required CartModel cart, required PizzaItemModel pizza})
    : super(CartState(cart: cart, pizza: pizza));
  List<PizzaItemModel> get items => state.cart.items;

  void addPizzaRecommended(PizzaItemModel pizza) {
    final items = List<PizzaItemModel>.from(state.cart.items);


    var newPizza = pizza.cloneForCart();
    newPizza = newPizza.copyWith(quantity: 1);

    items.add(newPizza);

    emit(state.copyWith(cart: state.cart.copyWith(items: items)));
  }

  void addOrIncreasePizza(PizzaItemModel pizza) {
    final items = List<PizzaItemModel>.from(state.cart.items);

    final index = items.indexWhere((e) => e.id == pizza.id);

    if (index == -1) {
      items.add(
        pizza.cloneForCart().copyWith(quantity: 1),
      );
    } else {
      final item = items[index];
      items[index] = item.copyWith(quantity: item.quantity + 1);
    }

    emit(state.copyWith(cart: state.cart.copyWith(items: items)));
  }

  void decreasePizzaInCart(PizzaItemModel pizza) {
    final index = state.cart.items.indexWhere((item) => item.id == pizza.id);
    if (index == -1) return;

    final updatedItems = List<PizzaItemModel>.from(state.cart.items);
    final item = updatedItems[index];

    if (item.quantity > 1) {
      updatedItems[index] = item.copyWith(quantity: item.quantity - 1);
    } else {
      updatedItems.removeAt(index);
    }
    emit(state.copyWith(cart: state.cart.copyWith(items: updatedItems)));
  }

  void toggleOption(PizzaItemModel pizza, PizzaItemModel option) {
    final items = List<PizzaItemModel>.from(state.cart.items);
    final index = items.indexWhere((e) => e.id == pizza.id);
    if (index == -1) return;

    final currentItem = items[index];
    final newSelectOptions = List<PizzaItemModel>.from(
      currentItem.selectOptions,
    );

    if (newSelectOptions.any((e) => e.id == option.id)) {
      newSelectOptions.removeWhere((e) => e.id == option.id);
    } else {
      newSelectOptions.add(option);
    }

    items[index] = currentItem.copyWith(selectOptions: newSelectOptions);
    emit(state.copyWith(cart: state.cart.copyWith(items: items)));
  }

  void clearCart() {
    emit(
      state.copyWith(cart: state.cart.copyWith(items: [], discountInput: 0)),
    );
  }

  void setDiscount(String value) {
    emit(
      state.copyWith(
        cart: state.cart.copyWith(discountInput: double.tryParse(value) ?? 0),
      ),
    );
  }

  void setDiscountType(DiscountType type) {
    emit(state.copyWith(cart: state.cart.copyWith(discountType: type)));
  }

  void setTaxPercent(double percent) {
    emit(state.copyWith(cart: state.cart.copyWith(taxPercent: percent)));
  }

  double itemTotalPrice(PizzaItemModel pizza) {
    final optionsPrice = pizza.selectOptions.fold(
      0.0,
      (sum, option) => sum + option.basePrice,
    );
    return (pizza.basePrice + optionsPrice) * pizza.quantity;
  }

  double get subTotal {
    return state.cart.items.fold(
      0.0,
      (sum, item) => sum + itemTotalPrice(item),
    );
  }
  double get totalPrice =>
      subTotal + tax + deliveryFee - discountAmount;


  int get deliveryFee => state.cart.deliveryFee;

  double get tax => subTotal * state.cart.taxPercent;

  double get discountAmount {
    switch (state.cart.discountType) {
      case DiscountType.percent:
        return subTotal * (state.cart.discountInput / 100);
      case DiscountType.fixed:
        return state.cart.discountInput;
      case DiscountType.none:
        return 0;
    }
  }
}
