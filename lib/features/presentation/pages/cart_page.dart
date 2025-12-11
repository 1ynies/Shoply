import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplyapp/features/data/models/cart_model.dart';
import 'package:shoplyapp/features/presentation/widget/round_navigation_button.dart';
import 'package:shoplyapp/features/presentation/widget/Cart_Item_widget.dart';

class CartPage extends StatelessWidget {
  // Mock data representing the 5 items in the image
  final List<CartItemModel> cartItems = [
    CartItemModel(
      productID: 'P001',
      variantID: 'hu7',
      quantity: 2,
      unitPrice: 12,
      name: 'T-Shirt',
      size: 'L',
      image: 'lib/assets/images/t-shirt_facing_stright.png',
    ),
    CartItemModel(
      productID: 'P002',
      variantID: 'hu8',
      quantity: 1,
      unitPrice: 15,
      name: 'T-Shirt',
      size: 'M',
      image: 'lib/assets/images/t-shirt_turning_right.png',
    ),
    CartItemModel(
      productID: 'P003',
      variantID: 'hu9',
      quantity: 3,
      unitPrice: 10,
      name: 'T-Shirt',
      size: 'S',
      image: 'lib/assets/images/t-shirt_facing_stright.png',
    ),
    CartItemModel(
      productID: 'P004',
      variantID: 'hu10',
      quantity: 1,
      unitPrice: 20,
      name: 'T-Shirt',
      size: 'XL',
      image: 'lib/assets/images/t-shirt_turning_right.png',
    ),
    CartItemModel(
      productID: 'P005',
      variantID: 'hu11',
      quantity: 2,
      unitPrice: 18,
      name: 'T-Shirt',
      size: 'XXL',
      image: 'lib/assets/images/t-shirt_facing_stright.png',
    ),
  ];

  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item.unitPrice * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Row(
                mainAxisAlignment: .start,
                children: [
                  const RoundNavigationButton(
                    Iconpath: 'lib/assets/svg/arrow_left.svg',
                    iconwidth: 24,
                    iconheight: 24,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Cart (${cartItems.length}) ',
                    style: GoogleFonts.manrope(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return CartItemWidget(item: cartItems[index]);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, -3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Checkbox and Total Price
                  Row(
                    children: [
                      // Global Checkbox
                      Container(
                        width: 18,
                        height: 18,
                        margin: const EdgeInsets.only(right: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.green.shade500,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Price',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '\$${totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(), // Pushes the checkout button to the end
                  // Checkout Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle checkout action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen.shade500,
                      minimumSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
