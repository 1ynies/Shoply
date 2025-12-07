class ProductEntity {
  final String productID;
  final String name;
  final String description;
  final double basePrice;
  final String categoryID;
  final double averageRating;
  final int reviewCount;
  bool isFavorite;

  ProductEntity({
    required this.productID,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.categoryID,
    required this.averageRating,
    required this.reviewCount,
    this.isFavorite = false
  });
  
  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
  static List<ProductEntity> mockProducts = [
  ProductEntity(
    productID: 'P001',
    name: 'Wireless Bluetooth Headphones',
    description: 'Over-ear headphones with noise cancellation and 20-hour battery life.',
    basePrice: 99.99,
    categoryID: 'CAT01',
    averageRating: 4.5,
    reviewCount: 150,
    isFavorite: true,
  ),
  ProductEntity(
    productID: 'P002',
    name: 'Stainless Steel Water Bottle',
    description: '24oz insulated bottle keeps drinks cold for 24 hours and hot for 12.',
    basePrice: 25.50,
    categoryID: 'CAT02',
    averageRating: 4.8,
    reviewCount: 320,
    isFavorite: false,
  ),
  ProductEntity(
    productID: 'P003',
    name: 'Organic Cotton T-Shirt',
    description: 'Soft, breathable tee made from 100% organic cotton.',
    basePrice: 19.95,
    categoryID: 'CAT03',
    averageRating: 4.2,
    reviewCount: 85,
  ),
  ProductEntity(
    productID: 'P004',
    name: 'Portable Power Bank 10000mAh',
    description: 'Fast charging power bank with dual USB ports.',
    basePrice: 45.00,
    categoryID: 'CAT01',
    averageRating: 4.6,
    reviewCount: 510,
    isFavorite: true,
  ),
  ProductEntity(
    productID: 'P005',
    name: 'Ergonomic Office Chair',
    description: 'Adjustable mesh chair designed for all-day comfort and support.',
    basePrice: 189.99,
    categoryID: 'CAT04',
    averageRating: 3.9,
    reviewCount: 45,
  ),
];
}