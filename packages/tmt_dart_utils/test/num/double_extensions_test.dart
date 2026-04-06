import 'package:test/test.dart';
import 'package:tmt_dart_utils/tmt_dart_extensions.dart';

void main() {
  group('DoubleExtensions', () {
    group('valueOrDefault', () {
      test('should return the value when double is not null', () {
        const double value = 123.45;
        expect(value.valueOrDefault(), 123.45);
      });

      test('should return zero (default) when double is null', () {
        const double? value = null;
        expect(value.valueOrDefault(), 0.0);
      });

      test('should return custom default value when double is null', () {
        const double? value = null;
        expect(value.valueOrDefault(99.9), 99.9);
      });

      test('should work with negative numbers', () {
        const double value = -456.78;
        expect(value.valueOrDefault(), -456.78);
      });

      test('should work with zero', () {
        const double value = 0.0;
        expect(value.valueOrDefault(), 0.0);
      });

      test('should work with very large numbers', () {
        const double value = 1.7976931348623157e+308; // max double
        expect(value.valueOrDefault(), 1.7976931348623157e+308);
      });

      test('should work with very small numbers', () {
        const double value = 2.2250738585072014e-308; // min positive double
        expect(value.valueOrDefault(), 2.2250738585072014e-308);
      });

      test('should work with infinity', () {
        const double value = double.infinity;
        expect(value.valueOrDefault(), double.infinity);
      });

      test('should work with negative infinity', () {
        const double value = double.negativeInfinity;
        expect(value.valueOrDefault(), double.negativeInfinity);
      });

      test('should work with NaN', () {
        const double value = double.nan;
        expect(value.valueOrDefault().isNaN, true);
      });
    });
  });
}
