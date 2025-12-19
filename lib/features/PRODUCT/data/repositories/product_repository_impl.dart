import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoplyapp/features/PRODUCT/domain/entities/Product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  // final FirebaseFirestore firestore;

  // ProductRepositoryImpl(this.firestore);

  // @override
  // Future<ProductEntity> getProductDetails(String productId) async {
  //   try {
  //     // 1. Fetch the product document from Firestore
  //     final doc = await firestore.collection('products').doc(productId).get();
      
  //     if (!doc.exists) {
  //       throw Exception("Product not found");
  //     }

  //     // 2. Convert raw data to our ProductModel
  //     final product = ProductModel.fromFirestore(doc.data()!, doc.id);
      
  //     return product;
  //   } catch (e) {
  //     throw Exception("Failed to fetch product: $e");
  //   }
  // }



  // == DUMMY DATA
  @override
  Future<ProductEntity> getProductDetails(String productId) async {
    // 1. Simulate a network delay (e.g., 1.5 seconds)
    await Future.delayed(const Duration(milliseconds: 1500));

    // 2. Return mock data that matches your Entity structure
    return ProductModel(
      productID: productId,
      name: "Knitted cloths women",
      description: "Discover the comfort and versatility of women’s knitted clothing. Crafted from high-quality yarns, our knits offer warmth, style, and effortless layering.",
      basePrice: 60.00,
      categoryID: "women-knits",
      averageRating: 5.0,
      reviewCount: 120,
      isFavorite: false,
      images: [
        'https://via.placeholder.com/300/E0E0E0/000000?text=Front', // Image 0
        'https://via.placeholder.com/300/D0D0D0/000000?text=Side',  // Image 1
        'https://via.placeholder.com/300/C0C0C0/000000?text=Back',  // Image 2
        'https://via.placeholder.com/300/B0B0B0/000000?text=Detail',// Image 3
      ],
    );
  }


}