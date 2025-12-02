import 'package:flutter/material.dart';
// Don't forget to import the package:
// Replace 'animated_bottom_navigation_bar' with the exact package name if different
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart'; 

class ButtomNavbar extends StatefulWidget {
  @override
  _ButtomNavbarState createState() => _ButtomNavbarState();
}

class _ButtomNavbarState extends State<ButtomNavbar> {
  // 1. State variable to track the currently selected index
  int _bottomNavIndex = 0; 

  // 2. List of icons for your navigation bar
  final List<IconData> iconList = <IconData>[
    Icons.home_filled, // Home
    Icons.favorite_border, // Heart/Favorites
    Icons.receipt_long, // Check/Orders
    Icons.person_outline, // Profile
  ];

  // (Optional) List of pages/screens corresponding to the tabs
  final List<Widget> pages = [
    Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Favorites Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Orders Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return  AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.none, // Use 'none' if you don't have a floating action button
        notchSmoothness: NotchSmoothness.verySmoothEdge, // For a smooth cutout
        leftCornerRadius: 32, // To match your image's rounded corners
        rightCornerRadius: 32, // To match your image's rounded corners
        elevation: 0, // Remove shadow
        
        // --- Custom Styling to Match Your Image ---
        backgroundColor: const Color(0xFF1E2D2B), // Dark background (adjust color as needed)
        inactiveColor: Colors.white,
        activeColor: Colors.lightGreenAccent, // Bright green active color
        
        // --- The most important function ---
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        // --- Animation Settings ---
        splashRadius: 0, // Optional: adjust splash effect
        
        // The bar can be set to hide on scroll by wrapping the Scaffold in a 
        // ScrollController and passing it to hideOnScroll.
      
    );
  }
}