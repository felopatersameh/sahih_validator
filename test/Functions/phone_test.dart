import 'package:flutter_test/flutter_test.dart';
import 'package:sahih_validator/sahih_validator.dart';

void phoneTest() {
  return group('Phone Validation', () {
    test('Empty phone should return error', () {
      final result = SahihValidator.phone(
        phone: '',
        emptyMessage: 'Phone is required',
      );
      expect(result, 'Phone is required');
    });

    test('Empty phone with default message', () {
      final result = SahihValidator.phone(phone: '');
      expect(result, 'Please enter your phone number.');
    });

    test('Phone with only whitespace should return error when trimmed', () {
      final result = SahihValidator.phone(phone: '   ', trimWhitespace: true);
      expect(result, 'Please enter your phone number.');
    });

    test('Phone with whitespace should be valid when trimmed', () {
      final result = SahihValidator.phone(
        phone: '   1234567890   ',
        trimWhitespace: true,
      );
      expect(result, null);
    });

    test('Phone with whitespace should be invalid when not trimmed', () {
      final result = SahihValidator.phone(
        phone: '   1234567890   ',
        trimWhitespace: false,
      );
      expect(
        result,
        'The phone number is invalid. Please enter a valid 10–15 digit number.',
      );
    });

    test('Invalid phone format should return error', () {
      final result = SahihValidator.phone(
        phone: '123',
        invalidFormatMessage: 'Invalid phone number',
      );
      expect(result, 'Invalid phone number');
    });

    test('Invalid phone format with default message', () {
      final result = SahihValidator.phone(phone: '123');
      expect(
        result,
        'The phone number is invalid. Please enter a valid 10–15 digit number.',
      );
    });

    test('Various invalid phone formats', () {
      final invalidPhones = [
        '123', // Too short
        '12345678901234567890', // Too long
        'abcdefghij', // Letters
        '123-456-7890', // Dashes
        '(123) 456-7890', // Parentheses and spaces
        '123.456.7890', // Dots
        '+', // Just plus
        '++1234567890', // Double plus
        '123 456 7890', // Spaces
      ];

      for (final phone in invalidPhones) {
        final result = SahihValidator.phone(phone: phone);
        expect(
          result,
          'The phone number is invalid. Please enter a valid 10–15 digit number.',
          reason: 'Phone "$phone" should be invalid',
        );
      }
    });

    test('Valid phone formats', () {
      final validPhones = [
        '1234567890', // 10 digits
        '12345678901', // 11 digits
        '123456789012345', // 15 digits
        '+1234567890', // With country code
        '+123456789012345', // With country code, max length
      ];

      for (final phone in validPhones) {
        final result = SahihValidator.phone(phone: phone);
        expect(result, null, reason: 'Phone "$phone" should be valid');
      }
    });

    test('Existing phone should return error', () {
      final result = SahihValidator.phone(
        phone: '1234567890',
        existingPhones: ['1234567890', '0987654321'],
        alreadyExistsMessage: 'Phone already exists',
      );
      expect(result, 'Phone already exists');
    });

    test('Existing phone with default message', () {
      final result = SahihValidator.phone(
        phone: '1234567890',
        existingPhones: ['1234567890'],
      );
      expect(result, 'This phone number is already registered.');
    });

    test('Valid phone should return null', () {
      final result = SahihValidator.phone(phone: '1234567890');
      expect(result, null);
    });

    test('Empty existing phones list should not cause error', () {
      final result = SahihValidator.phone(
        phone: '1234567890',
        existingPhones: [],
      );
      expect(result, null);
    });
  });
}
