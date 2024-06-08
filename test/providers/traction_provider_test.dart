import 'package:ankigpt/src/providers/traction_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatTraction', () {
    test('should format traction correctly', () {
      // Test cases
      final testCases = {
        0: '0',
        1: '1',
        10: '10',
        100: '100',
        1000: '1,000',
        10000: '10,000',
        100000: '100,000',
        1000000: '1,000,000',
      };

      // Run tests
      testCases.forEach((input, expected) {
        final result = formatTraction(input);
        expect(result, expected);
      });
    });
  });
}
