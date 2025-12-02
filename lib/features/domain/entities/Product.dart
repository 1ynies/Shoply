class Product {
  final String name;
  final String price;
  final String imagePath;
  final bool isFavorite;

  Product({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.isFavorite,
  });

  static final List<Product> products = [
    Product(
      name: 'T-shirt',
      price: '90.00',
      imagePath: 'assets/tshirt1.png',
      isFavorite: true,
    ),
    Product(
      name: 'Sweater',
      price: '120.00',
      imagePath: 'assets/sweater.png',
      isFavorite: false,
    ),
    Product(
      name: 'Jeans',
      price: '75.00',
      imagePath: 'assets/jeans.png',
      isFavorite: true,
    ),
    Product(
      name: 'Sneakers',
      price: '150.00',
      imagePath: 'assets/shoes.png',
      isFavorite: false,
    ),
    Product(
      name: 'Jacket',
      price: '200.00',
      imagePath: 'assets/jacket.png',
      isFavorite: false,
    ),
  ];
}
