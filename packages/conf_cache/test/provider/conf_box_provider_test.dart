import 'package:conf_cache/src/provider/conf_box_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/hive_test_helper.dart';
import '../mocks/generated_mocks.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    HiveTestHelper.setUp();
  });

  setUp(ConfBoxProvider.clearTestBoxes);

  tearDownAll(HiveTestHelper.tearDown);

  group('ConfBoxProvider', () {
    test('returns registered test box when available', () async {
      final mockBox = MockBox<String>();
      ConfBoxProvider.registerTestBox('test_box_name', mockBox);

      final result = await ConfBoxProvider.getBox('test_box_name');

      expect(
        identical(result, mockBox),
        isTrue,
        reason: 'Expected same mock box instance',
      );
    });

    test('returns the same box for repeated calls', () async {
      final box1 = await ConfBoxProvider.getBox('repeated_test');
      final box2 = await ConfBoxProvider.getBox('repeated_test');
      expect(identical(box1, box2), isTrue);
    });

    test('closeAll correctly closes and clears all boxes', () async {
      await ConfBoxProvider.getBox('box1');
      await ConfBoxProvider.getBox('box2');

      expect(ConfBoxProvider.hasBox('box1'), isTrue);
      expect(ConfBoxProvider.hasBox('box2'), isTrue);

      await ConfBoxProvider.closeAll();

      expect(ConfBoxProvider.hasBox('box1'), isFalse);
      expect(ConfBoxProvider.hasBox('box2'), isFalse);
    });
  });
}
