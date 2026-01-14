import 'package:flutter/material.dart';
import 'package:pizzashop/data/models/cart_model.dart';
import 'package:pizzashop/presentation/widgets/summary_row.dart';

class CheckoutScreen extends StatelessWidget {
  final CartModel cartModel;
  final double subTotal;
  final int deliveryFee;
  final double tax;
  final double discount;
  final double total;

  const CheckoutScreen({
    super.key,
    required this.cartModel,
    required this.subTotal,
    required this.deliveryFee,
    required this.tax,
    required this.discount,
    required this.total,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Summary',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SummaryRow(title: 'Subtotal', value: '\$${subTotal.toStringAsFixed(2)}'),
                  SummaryRow(title: 'Delivery Fee', value: '\$${deliveryFee.toStringAsFixed(2)}'),
                  SummaryRow(title: 'Tax', value: '\$${tax.toStringAsFixed(2)}'),
                  SummaryRow(title: 'Discount', value: '-\$${discount.toStringAsFixed(2)}'),
                  const Divider(height: 24),
                  SummaryRow(title: 'Total', value: '\$${total.toStringAsFixed(2)}', isTotal: true),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.payment),
                  SizedBox(width: 12),
                  Text(
                    'Cash on Delivery',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Confirm Order',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
