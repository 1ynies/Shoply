import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplyapp/features/domain/entities/Category.dart';
import 'package:shoplyapp/features/domain/entities/Product.dart';
import 'package:shoplyapp/features/presentation/widget/buttom_navbar.dart';
import 'package:shoplyapp/features/presentation/widget/category_chip.dart';
import 'package:shoplyapp/features/presentation/widget/green_round_button.dart';
import 'package:shoplyapp/features/presentation/widget/product_card.dart';
import 'package:shoplyapp/features/presentation/widget/round_navigation_button.dart';
import 'package:shoplyapp/features/presentation/widget/search_field.dart';
import 'package:shoplyapp/features/presentation/widget/shoply_text&logo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategoryId = 'all';

  

  List<Product> get _filteredProducts {
    if (_selectedCategoryId == 'all') {
      // ➡️ CHANGED: Accessed the now-public static list Product.products
      return Product.products; 
    }
    
    // NOTE: For simplicity, this filter checks if the product name contains the category ID.
    // In a production app, the Product model should have a dedicated 'categoryId' field.
    // ➡️ CHANGED: Accessed the now-public static list Product.products
    return Product.products.where((product) {
      return product.name.toLowerCase().contains(_selectedCategoryId.replaceAll('-', ' '));
    }).toList();
  } 




  
  
  void _handleCategorySelected(String categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
      // In a real application, this would trigger data fetching/UI update for products
      print('Selected Category: $_selectedCategoryId');
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _filteredProducts;
    
    // Calculate the height required for the GridView based on the number of filtered items.
    // Each row has 2 items. We assume a card height of approx 300px + 12px spacing.
    final double gridHeight = (filteredProducts.length / 2).ceil() * (300.0 + 12.0);
    return Scaffold(
      bottomNavigationBar: ButtomNavbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: .all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: .start,
              children: [
                _topPart(),
                const SizedBox(height: 16),
                _searchSection(),
                const SizedBox(height: 16),
                _adCard(),
                const SizedBox(height: 16),
                _categoriesList(),
                

                SizedBox(
                  // Set explicit height to allow GridView inside SingleChildScrollView
                  height: gridHeight, 
                  child: GridView.builder(
                    // FIX: Must prevent GridView from scrolling independently
                    physics: const NeverScrollableScrollPhysics(), 
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // ⭐️ TWO ITEMS PER ROW
                      crossAxisSpacing: 8.0, // Horizontal spacing
                      mainAxisSpacing: 8.0, // Vertical spacing
                      childAspectRatio: 0.75, // Adjust this ratio for card dimensions
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      // Pass the product data to the card
                      return ProductCard(product: product); 
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _categoriesList() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mockCategories.length,
        itemBuilder: (context, index) {
          final category = mockCategories[index];
          final isSelected = category.id == _selectedCategoryId;

          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CategoryChip(
              category: category,
              isSelected: isSelected,
              onSelected: _handleCategorySelected,
            ),
          );
        },
      ),
    );
  }

  // -- this is the ad space --
  Container _adCard() {
    return Container(
      width: 100,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF030712),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  'Get your special\nsale up to 50%',
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: .start,
                  children: [
                    Container(
                      width: 100,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color(0xFF9AE600),
                        borderRadius: BorderRadius.circular(50),
                      ),

                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            'Shop now',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),
                    GreenRoundButton(
                      Iconpath: 'lib/assets/svg/arrow_up_right.svg',
                      iconwidth: 24,
                      iconheight: 24,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 16),
            Image.asset(
              'lib/assets/images/t-shirt_turning_right.png',
              width: 130,
              height: 130,
            ),
          ],
        ),
      ),
    );
  }

  Row _searchSection() {
    return Row(
      crossAxisAlignment: .center,
      children: [
        Expanded(child: SearchField()),
        const SizedBox(width: 16),
        GreenRoundButton(
          Iconpath: 'lib/assets/svg/filter.svg',
          iconwidth: 24,
          iconheight: 24,
        ),
      ],
    );
  }

  Row _topPart() {
    return Row(
      children: [
        ShoplyTextlogo(),
        const Spacer(),
        RoundNavigationButton(
          Iconpath: 'lib/assets/svg/cart.svg',
          iconwidth: 24,
          iconheight: 24,
        ),
        const SizedBox(width: 10),
        RoundNavigationButton(
          Iconpath: 'lib/assets/svg/bell.svg',
          iconheight: 30,
          iconwidth: 30,
        ),
      ],
    );
  }
}
