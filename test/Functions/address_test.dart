import 'package:flutter_test/flutter_test.dart';
import 'package:sahih_validator/sahih_validator.dart';

void addressTest() {
  return group('Address Validation', () {
    test('Empty address should return error when required', () {
      final result = SahihValidator.address(address: '', isRequired: true);
      expect(result, 'Address is required');
    });

    test('Address length validation', () {
      expect(
        SahihValidator.address(address: 'short', minLength: 10),
        contains('must be at least 10 characters'),
      );
      expect(
        SahihValidator.address(address: 'a' * 201, maxLength: 200),
        contains('cannot exceed 200 characters'),
      );
    });

    test('Address component requirements', () {
      expect(
        SahihValidator.address(
          address: 'Main Streett',
          requireStreetNumber: true,
        ),
        contains('must include a street number'),
      );
      expect(
        SahihValidator.address(address: '12345678910', requireStreetName: true),
        contains('must include a street name'),
      );
    });

    test('Valid address should return null', () {
      expect(SahihValidator.address(address: "validAddress"), null);
    });
  });
}
