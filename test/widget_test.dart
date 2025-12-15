import 'package:flutter_test/flutter_test.dart';
import 'package:shoplyapp/features/INTRO/presentation/pages/splash_screen.dart'; // Import SplashScreen
import 'package:shoplyapp/main.dart';

void main() {
  testWidgets('App starts and shows splash screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the SplashScreen is shown.
    expect(find.byType(ShoplySplashScreen), findsOneWidget);

    // You might want to add a delay and then check for navigation if the splash screen
    // navigates automatically after a duration.
    // For example: await tester.pumpAndSettle(const Duration(seconds: 3));
    // Then check for the next expected widget after navigation.
  });
}
