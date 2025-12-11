import 'package:shoplyapp/features/domain/entities/Cart_entity.dart';

class CartItemModel extends CartItemEntity {
  CartItemModel({
    required super.productID,
    required super.variantID,
    required super.quantity,
    required super.unitPrice,
    required super.name,
    required super.size,
    required super.image,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productID: json['productID'] as String,
      variantID: json['variantID'] as String,
      quantity: json['quantity'] as int,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      name: json['name'] as String? ?? '',
      size: json['size'] as String? ?? '',
      image: json['image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productID': productID,
      'variantID': variantID,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'name': name,
      'size': size,
      'image': image,
    };
  }
}

class CartModel extends CartEntity {
  CartModel({
    required super.cartID,
    required super.userID,
    required super.items,
  });

  factory CartModel.fromJson(Map<String, dynamic> json, String id) {
    List<CartItemEntity> cartItems = (json['items'] as List<dynamic>?)
            ?.map((itemJson) =>
                CartItemModel.fromJson(itemJson as Map<String, dynamic>))
            .toList() ??
        [];

    return CartModel(
      cartID: id,
      userID: json['userID'] as String,
      items: cartItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'items': items.map((item) => (item as CartItemModel).toJson()).toList(),
    };
  }
}