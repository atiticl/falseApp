import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/main.dart';
import 'package:app/services/storage_service.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await StorageService().init();
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('首页'), findsWidgets);
    expect(find.text('我的申请'), findsWidgets);
  });
}
