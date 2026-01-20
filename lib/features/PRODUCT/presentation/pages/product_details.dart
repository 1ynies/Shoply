import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import 'package:google_fonts/google_fonts.dart';



class ProductDetailsPage extends StatelessWidget {
  final String productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    // We assume ProductBloc is provided above this widget (e.g., in your Router)
    // If not, wrap this Scaffold in a BlocProvider.
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // Light background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          "Product details",
          style: GoogleFonts.manrope(
            textStyle: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Dynamic Image Gallery
                      _buildImageGallery(context, state),

                      const SizedBox(height: 20),

                      // 2. Product Info (Best Seller, Title, Price)
                      _buildProductInfo(context, state),

                      const SizedBox(height: 20),

                      // 3. Size Selection
                      _buildSizeSelector(context, state),

                      const SizedBox(height: 30),

                      // 4. Buy Actions
                      _buildBottomAction(context, state),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }

  // --- SECTION 1: IMAGE GALLERY ---
  Widget _buildImageGallery(BuildContext context, ProductLoaded state) {
    final images = state.product.images;
    final selectedIndex = state.selectedImageIndex;

    // Safety check if no images exist
    if (images.isEmpty)
      return const SizedBox(
        height: 200,
        child: Center(child: Text("No images")),
      );

    return Column(
      children: [
        // A. Large Preview Image
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200], // Placeholder color
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(images[selectedIndex]), // Load selected URL
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // B. Thumbnails Row
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemBuilder: (context, index) {
              final isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () {
                  // EVENT: Update selected image index
                  context.read<ProductBloc>().add(SelectImageEvent(index));
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                    // UI: Green border when selected
                    border: isSelected
                        ? Border.all(color: const Color(0xFFAEDC81), width: 2)
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // --- SECTION 2: PRODUCT INFO ---
  Widget _buildProductInfo(BuildContext context, ProductLoaded state) {
    final product = state.product;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Best seller",
          style: TextStyle(
            color: Color(0xFFAEDC81), // Match UI Green
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Expanded(
              child: Text(
                product.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Favorite Toggle
            IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: product.isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                context.read<ProductBloc>().add(ToggleFavoriteEvent());
              },
            ),
          ],
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${product.basePrice.toStringAsFixed(2)}\$",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const Gap(4),
                Text(
                  product.averageRating.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        const Gap(15),
        Text(
          product.description,
          style: TextStyle(color: Colors.grey[600], height: 1.4),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // --- SECTION 3: SIZES ---
  Widget _buildSizeSelector(BuildContext context, ProductLoaded state) {
    final sizes = ['S', 'M', 'L', 'XL', 'XXL'];
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: sizes.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = state.selectedSize == sizes[index];
          return GestureDetector(
            onTap: () =>
                context.read<ProductBloc>().add(SelectSizeEvent(sizes[index])),
            child: Container(
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[300]!),
                color: isSelected ? Colors.black : Colors.white,
              ),
              child: Text(
                sizes[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- SECTION 4: BUY ACTIONS ---
  Widget _buildBottomAction(BuildContext context, ProductLoaded state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Buy item :",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                _quantityButton(
                  icon: Icons.remove,
                  onTap: () =>
                      context.read<ProductBloc>().add(UpdateQuantityEvent(-1)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    state.quantity.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                _quantityButton(
                  icon: Icons.add,
                  isDark: true,
                  onTap: () =>
                      context.read<ProductBloc>().add(UpdateQuantityEvent(1)),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            // Cart Icon Badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
                Positioned(
                  right: -5,
                  top: -5,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color(0xFFAEDC81),
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      "1",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            // Buy Button
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Add to cart logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.grey[700],
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Buy now",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
    bool isDark = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF283e1e) : Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isDark ? Colors.white : Colors.black,
          size: 20,
        ),
      ),
    );
  }
}
