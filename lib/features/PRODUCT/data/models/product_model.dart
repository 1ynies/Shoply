

import 'package:shoplyapp/features/PRODUCT/domain/entities/Product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.productID,
    required super.name,
    required super.description,
    required super.basePrice,
    required super.categoryID,
    super.category,
    required super.averageRating,
    required super.reviewCount,
    super.isFavorite,
    required super.images,
  });

  // Converts Firestore Document into ProductModel
  factory ProductModel.fromFirestore(Map<String, dynamic> json, String docId) {
    return ProductModel(
      productID: docId,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      basePrice: (json['basePrice'] ?? 0).toDouble(),
      categoryID: json['categoryID'] ?? '',
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      isFavorite: json['isFavorite'] ?? false,
      // Safely convert JSON list to List<String>
      images: List<String>.from(json['images'] ?? []),
    );
  }

  // Converts Model back to JSON for saving to Firebase
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'basePrice': basePrice,
      'categoryID': categoryID,
      'averageRating': averageRating,
      'reviewCount': reviewCount,
      'isFavorite': isFavorite,
      'images': images,
    };
  }
}