import 'package:pizzashop/data/models/pizza_item_model.dart';

import '../../presentation/cubits/cart_cubit.dart';

class CartModel {
  final List<PizzaItemModel> items;
   final int deliveryFee;
   final double taxPercent;
  final DiscountType discountType;
   final double  discountInput;

  const CartModel({
    required this.items,
    this.deliveryFee = 5,
    this.taxPercent = 0.14,
    this.discountType = DiscountType.none,
    this.discountInput = 0,
  });

  CartModel copyWith({
    List<PizzaItemModel>? items,
    int? deliveryFee,
    double? taxPercent,
    DiscountType? discountType,
    double? discountInput,
  }) {
    return CartModel(
      items: items ?? this.items,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      taxPercent: taxPercent ?? this.taxPercent,
      discountType: discountType ?? this.discountType,
      discountInput: discountInput ?? this.discountInput,
    );
  }
}
