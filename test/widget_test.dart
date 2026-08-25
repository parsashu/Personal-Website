import 'package:flutter_test/flutter_test.dart';
import 'package:personal_site/main.dart';

void main() {
  testWidgets('Renders academic home brand', (tester) async {
    await tester.pumpWidget(const PersonalSiteApp());
    expect(find.textContaining('PARSA SHAHIDI'), findsWidgets);
  });
}
