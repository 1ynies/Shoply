


class Category {
  final String categoryID;
  final String name;
  

  Category({
    required this.categoryID,
    required this.name,
    
  });
  
  static List<Category> mockCategories = [
  Category(categoryID: 'all', name: 'All'),
  Category(categoryID: 'CAT01', name: 'Electronics'),
  Category(categoryID: 'CAT02', name: 'Household'),
  Category(categoryID: 'CAT03', name: 'Apparel'),
  Category(categoryID: 'CAT04', name: 'Furniture'),
  
];
}