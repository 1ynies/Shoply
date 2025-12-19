import 'package:flutter/foundation.dart';

class ProductEntity {
  final String productID;
  final String name;
  final String description;
  final double basePrice;
  final String categoryID;
  final Category? category;
  final double averageRating;
  final int reviewCount;
  bool isFavorite;

  // ADDED: A list to hold the gallery images
  final List<String> images;

  ProductEntity({
    required this.productID,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.categoryID,
    this.category,
    required this.averageRating,
    required this.reviewCount,
    this.isFavorite = false,
    required this.images,
  });
  
  void toggleFavorite() {
    isFavorite = !isFavorite;
  }

  


  
}