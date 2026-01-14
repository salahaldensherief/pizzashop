
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzashop/presentation/checkout_screen.dart';
import 'package:pizzashop/presentation/widgets/cart_item.dart';
import 'package:pizzashop/presentation/widgets/discount_widget.dart';
import 'package:pizzashop/presentation/widgets/payment_summary_widget.dart';
import 'package:pizzashop/presentation/widgets/recommended_pizza_widget.dart';
import 'cubits/cart_cubit.dart';
import 'cubits/cart_state.dart';
class PizzaCartScreen extends StatelessWidget {
  const PizzaCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final total = context.read<CartCubit>().totalPrice;

        final cart = state.cart;
        return cart.items.isEmpty
            ? Scaffold(
                appBar: AppBar(title: Text('Cart')),
                body: Center(child: Text('cart is empty')),
              )
            : Scaffold(
                appBar: AppBar(title:  Text('Cart')),
                bottomNavigationBar: Container(
                  color: Colors.white,
                  padding:  EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Total: \$${total.clamp(0, double.infinity).toStringAsFixed(2)}',
                        style:  TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                       Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          final cubit = context.read<CartCubit>();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CheckoutScreen(
                                cartModel: cubit.state.cart,
                                subTotal: cubit.subTotal,
                                deliveryFee: cubit.deliveryFee,
                                tax: cubit.tax,
                                discount: cubit.discountAmount,
                                total: cubit.totalPrice,
                              ),
                            ),
                          );
                        },
                        child:  Text("Checkout"),
                      ),
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                  padding:  EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics:  NeverScrollableScrollPhysics(),
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final pizza = cart.items[index];
                          return Padding(
                            padding:  EdgeInsets.only(bottom: 16),
                            child: CartItem(
                              pizza: pizza,
                              onIncreaseQty: () => context
                                  .read<CartCubit>()
                                  .addOrIncreasePizza(pizza),
                              onDecreaseQty: () => context
                                  .read<CartCubit>()
                                  .decreasePizzaInCart(pizza),
                            ),
                          );
                        },
                      ),

                       SizedBox(height: 20),
                      RecommendedPizzaWidget(
                        onAdd: (pizza) {
                          context.read<CartCubit>().addPizzaRecommended(pizza);
                        },
                      ),
                       SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              final isSelected =
                                  state.cart.discountType ==
                                  DiscountType.percent;
                              return DiscountWidget(
                                color: isSelected
                                    ? Colors.green.withOpacity(0.3)
                                    : Colors.black12,
                                icon:  Icon(
                                  Icons.percent,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  context.read<CartCubit>().setDiscountType(
                                    DiscountType.percent,
                                  );
                                },
                              );
                            },
                          ),
                           SizedBox(width: 20),
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              final isSelected =
                                  state.cart.discountType == DiscountType.fixed;
                              return DiscountWidget(
                                color: isSelected
                                    ? Colors.green.withOpacity(0.3)
                                    : Colors.black12,
                                icon:  Icon(
                                  Icons.monetization_on,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  context.read<CartCubit>().setDiscountType(
                                    DiscountType.fixed,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                       SizedBox(height: 20),

                      TextField(
                        keyboardType: TextInputType.number,
                        decoration:  InputDecoration(
                          labelText: 'Discount',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          context.read<CartCubit>().setDiscount(value);
                        },
                      ),

                       SizedBox(height: 20),
                       Text(
                        'Payment summary',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       SizedBox(height: 20),

                      PaymentSummaryWidget(
                        label: 'Subtotal',
                        value:
                            '\$${context.read<CartCubit>().subTotal.toStringAsFixed(2)}',
                      ),
                       SizedBox(height: 10),
                      PaymentSummaryWidget(
                        label: 'Delivery fee',
                        value:
                            '\$${context.read<CartCubit>().deliveryFee.toStringAsFixed(2)}',
                      ),
                       SizedBox(height: 10),
                      PaymentSummaryWidget(
                        label: 'Tax Amount',
                        value:
                            '\$${context.read<CartCubit>().tax.toStringAsFixed(2)}',
                      ),
                       SizedBox(height: 10),
                      PaymentSummaryWidget(
                        label: 'Discount',
                        value:
                            '-\$${context.read<CartCubit>().discountAmount.toStringAsFixed(2)}',
                      ),
                       SizedBox(height: 10),
                      PaymentSummaryWidget(
                        label: 'Total',
                        value:
                            '\$${context.read<CartCubit>().totalPrice.toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
