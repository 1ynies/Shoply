class CartItemEntity {
  final String productID;
  final String variantID;
  final int quantity;
  final double unitPrice;
  final String name;
  final String size;
  final String image;


  CartItemEntity({
    required this.productID,
    required this.variantID,
    required this.quantity,
    required this.unitPrice,
    required this.name,
    required this.size,
    required this.image,
  });
}



class CartEntity {
  final String cartID;
  final String userID;
  final List<CartItemEntity> items;

  CartEntity({
    required this.cartID,
    required this.userID,
    required this.items,
  });

  double get total => items.fold(
      0.0, (sum, item) => sum + (item.unitPrice * item.quantity));
}