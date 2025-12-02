class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});
}

// 2. Mock Data
// In a real app, this data would come from an API or database.
final List<Category> mockCategories = [
  Category(id: 'all', name: 'All'),
  Category(id: 'tshirt', name: 'T-Shirt'),
  Category(id: 'jacket', name: 'Jacket'),
  Category(id: 'shoes', name: 'Shoes'),
  Category(id: 'jeans', name: 'Jeans'),
  Category(id: 'hats', name: 'Hats'),
  Category(id: 'accessories', name: 'Accessories'),
];