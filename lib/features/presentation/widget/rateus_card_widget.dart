import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplyapp/features/presentation/widget/submit_like_button.dart';

class RateusCardWidget extends StatefulWidget {
  @override
  State<RateusCardWidget> createState() => _RateusCardWidgetState();
}

class _RateusCardWidgetState extends State<RateusCardWidget> {
  // Function to build a single star icon
  Widget _buildStaticStar(int index) {
    // Logic to visually fill the stars up to a certain point (e.g., 5)
    final isFilled =
        index <=
        5; // Display all 5 stars as outlined or filled (e.g., set to 5 for filled appearance)

    return SvgPicture.asset(
      'lib/assets/svg/star_outline.svg',
      color: Colors.grey.shade400,
      width: 36,
      height: 36,
    );

    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: SvgPicture.asset('lib/assets/svg/delete.svg'),
              onPressed: () => Navigator.of(context).pop(), // Closes the dialog
            ),
          ),
          const Text(
            'Thank you',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          // 3. Prompt Text
          const Text(
            'How about giving us a rate',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),

          const SizedBox(height: 24),
          // 4. Static Rating Stars (Row is NOT clickable)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // Generates 5 static star icons
            children: List.generate(5, (index) => _buildStaticStar(index + 1)),
          ),
          // Spacer
          const SizedBox(height: 30),
          // Spacer
          
          Row(
            children: [
              Expanded(
                child: SubmitLikeButton(
                  onPressed: () {
                    //TODO: OPEN AN OUTSIDE LINK IN HERE
                  },
                  title: 'Rate us',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 6. "No, thank you" Link
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Text(
              'No, thank you',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }
}
