import 'package:flutter/material.dart';
import 'package:shoplyapp/features/domain/entities/Category.dart';

class CategoryChip extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final Function(String) onSelected;

  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Define the colors based on the selection state
    final Color backgroundColor = isSelected
        ? Colors.black
        : const Color(0xFFEEEEEE);
    final Color textColor = isSelected ? Colors.white : Colors.black87;

    return GestureDetector(
      onTap: () => onSelected(category.id),
      child: Container(
        // Set fixed dimensions similar to the image
        constraints: const BoxConstraints(minWidth: 50),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            50,
          ), // High border radius for pill shape
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          category.name,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
