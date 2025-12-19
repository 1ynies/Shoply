import 'package:shoplyapp/features/PRODUCT/domain/entities/Product_entity.dart';



abstract class ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final ProductEntity product;
  final String selectedSize;
  final int quantity;
    // ADDED: Track which image is currently selected in the gallery
  final int selectedImageIndex;

  ProductLoaded({
    required this.product,
    this.selectedSize = '',
    this.quantity = 1,
    this.selectedImageIndex = 0,
  });

  // copyWith allows us to change one part of the state (like size) 
  // without losing the product data.
  ProductLoaded copyWith({
    ProductEntity? product,
    String? selectedSize,
    int? quantity,
    int? selectedImageIndex,

  
  }) {
    return ProductLoaded(
      product: product ?? this.product,
      selectedSize: selectedSize ?? this.selectedSize,
      quantity: quantity ?? this.quantity,
      selectedImageIndex: selectedImageIndex ?? this.selectedImageIndex,
  
    );
  }
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}