

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplyapp/features/data/models/cart_model.dart';

class CartItemWidget extends StatefulWidget {
  final CartItemModel item;

  // Optional: Add an onChanged callback to communicate with the parent
  final ValueChanged<bool?>? onSelected;

  const CartItemWidget({super.key, required this.item, this.onSelected});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  // for the checkbox
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: .center,
            children: [
              // -- CHECKBOX --
              Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 12.0),
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: Checkbox(
                    value: _isSelected,

                    onChanged: (bool? newValue) {
                      setState(() {
                        _isSelected = newValue ?? false;
                      });
                      // 4. Call the optional callback if provided
                      if (widget.onSelected != null) {
                        widget.onSelected!(newValue);
                      }
                    },
                    activeColor: Colors.green.shade500,
                    checkColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    side: BorderSide(
                      color: Colors
                          .grey
                          .shade400, // Optional: border color when unchecked
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              // -- PRODUCT IMAGE--
              Container(
                width: 104,
                height: 104,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade200,
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.all(8),
                  child: Image.asset(widget.item.image),
                ),
              ),

              const SizedBox(width: 12),

              // Details (Name, Size, Price)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: .spaceBetween,
                  
                  children: [
                    Text(
                      widget.item.name,
                      style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      'Size = ${widget.item.size}',
                      style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      '\$${widget.item.unitPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Quantity Selector
              Column(
                mainAxisAlignment: .end,
                
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Minus button
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.remove,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          widget.item.quantity.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // Plus button
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.green.shade500,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Divider between items (optional, but good for separation)
          // const Divider(height: 16, thickness: 1, indent: 30),
        ],
      ),
    );
  }
}
