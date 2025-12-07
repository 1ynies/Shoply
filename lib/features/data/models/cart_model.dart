import 'package:shoplyapp/features/domain/entities/Cart_entity.dart';

class CartItemModel extends CartItemEntity {
  CartItemModel({
    required super.productID,
    required super.variantID,
    required super.quantity,
    required super.unitPrice,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productID: json['productID'] as String,
      variantID: json['variantID'] as String,
      quantity: json['quantity'] as int,
      unitPrice: (json['unitPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productID': productID,
      'variantID': variantID,
      'quantity': quantity,
      'unitPrice': unitPrice,
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