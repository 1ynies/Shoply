import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplyapp/features/domain/entities/Product_entity.dart';
import 'package:shoplyapp/features/presentation/widget/green_round_button.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  const ProductCard({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(19)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Image and Heart Icon (Stack)
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  // Placeholder for your 3D Image
                  Container(
                    width: 176,
                    height: 176,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(19),
                    ),
                    child: Center(
                      child: Image.asset('lib/assets/images/t-shirt_facing_stright.png'),
                    ),
                  ),

                  // Heart Icon
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                      size: 25.0,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8.0),

            // Product Details (Text and Button)
            Text(
              product.name,
              style: GoogleFonts.manrope(textStyle: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400)),
            ),
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Price
                Text(
                  '\$${product.basePrice}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Circular Action Button
                SizedBox(
                  width: 40,
                  height: 40,
                  child: GreenRoundButton(
                    Iconpath: 'lib/assets/svg/arrow_up_right.svg',
                    iconwidth: 24,
                    iconheight: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
