import 'package:flutter/material.dart';
import 'package:shoplyapp/features/domain/entities/Product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  const ProductCard({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Card(
      // elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
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
                    decoration: BoxDecoration(
                      color: Colors.grey[200], 
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  
                  // Heart Icon
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: Icon(
                      product.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 8.0),
            
            // Product Details (Text and Button)
            Text(
              product.name,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Price
                Text(
                  '\$${product.basePrice}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                // Circular Action Button
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Color(0xFF9AE600),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.arrow_upward,
                      color: Colors.black, // Changed to black for contrast
                      size: 18.0,
                    ),
                    onPressed: () {
                      debugPrint('Viewing product: ${product.name}');
                    },
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