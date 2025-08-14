import 'package:flutter_test/flutter_test.dart';
import 'package:sahih_validator/sahih_validator.dart';

void customValidationTest() {
  return group('Custom Validation', () {
    test('Required field empty should return error', () {
      final result = SahihValidator.custom(
        value: '',
        isRequired: true,
        emptyMessage: 'Field is required',
      );
      expect(result, 'Field is required');
    });

    test('Min length violation should return error', () {
      final result = SahihValidator.custom(
        value: '123',
        minLength: 5,
        minLengthMessage: 'Minimum 5 characters',
      );
      expect(result, 'Minimum 5 characters');
    });

    test('Max length violation should return error', () {
      final result = SahihValidator.custom(
        value: '123456',
        maxLength: 5,
        maxLengthMessage: 'Maximum 5 characters',
      );
      expect(result, 'Maximum 5 characters');
    });

    test('Pattern mismatch should return error', () {
      final result = SahihValidator.custom(
        value: 'abc',
        pattern: r'^\d+$', // Numbers only
        invalidPatternMessage: 'Numbers only',
      );
      expect(result, 'Numbers only');
    });

    test('Allow only numbers violation should return error', () {
      final result = SahihValidator.custom(
        value: 'abc123',
        allowOnlyNumbers: true,
        invalidNumberMessage: 'Numbers only allowed',
      );
      expect(result, 'Numbers only allowed');
    });

    test('Allow only letters violation should return error', () {
      final result = SahihValidator.custom(
        value: '123abc',
        allowOnlyLetters: true,
        invalidLettersMessage: 'Letters only allowed',
      );
      expect(result, 'Letters only allowed');
    });

    test('Custom validator function should return error', () {
      final result = SahihValidator.custom(
        value: 'invalid',
        customValidator: (val) => val == 'valid' ? null : 'Custom error',
      );
      expect(result, 'Custom error');
    });

    test('Existing value should return error', () {
      final result = SahihValidator.custom(
        value: 'duplicate',
        existingValues: ['duplicate', 'test'],
        alreadyExistsMessage: 'Value already exists',
      );
      expect(result, 'Value already exists');
    });

    test('Valid input should return null', () {
      final result = SahihValidator.custom(
        value: 'valid_value',
        minLength: 5,
        maxLength: 20,
      );
      expect(result, null);
    });
  });
}
