import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:textile_markaz/controllers/textile_search_controller.dart';
import 'package:textile_markaz/main.dart';

void main() {
  testWidgets('App shows home title', (WidgetTester tester) async {
    Get.put(TextileSearchController(), permanent: true);
    await tester.pumpWidget(const TextileMarkazApp());
    expect(find.text('Textile Markaz'), findsOneWidget);
  });
}
