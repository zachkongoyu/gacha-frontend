import 'package:flutter_test/flutter_test.dart';
import 'package:gacha_frontend/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const GachaApp());

    // Verify that the app initializes
    expect(find.text('Gacha Banners'), findsOneWidget);
  });
}
