import 'package:flutter_test/flutter_test.dart';
import 'package:sahih_validator/sahih_validator.dart';

void main() {
  group('Email Validation', () {
    test('Empty email should return error', () {
      final result = SahihValidator.email(
        email: '',
        emptyMessage: 'Email is required',
      );
      expect(result, 'Email is required');
    });

    test('Invalid email format should return error', () {
      final result = SahihValidator.email(
        email: 'invalid-email',
        invalidFormatMessage: 'Invalid email format',
      );
      expect(result, 'Invalid email format');
    });

    test('Existing email should return error', () {
      final result = SahihValidator.email(
        email: 'existing@test.com',
        existingEmails: ['existing@test.com', 'user@test.com'],
        alreadyExistsMessage: 'Email already exists',
      );
      expect(result, 'Email already exists');
    });

    test('Valid email should return null', () {
      final result = SahihValidator.email(email: 'valid@test.com');
      expect(result, null);
    });
  });

  group('Phone Validation', () {
    test('Empty phone should return error', () {
      final result = SahihValidator.phone(
        phone: '',
        emptyMessage: 'Phone is required',
      );
      expect(result, 'Phone is required');
    });

    test('Invalid phone format should return error', () {
      final result = SahihValidator.phone(
        phone: '123',
        invalidFormatMessage: 'Invalid phone number',
      );
      expect(result, 'Invalid phone number');
    });

    test('Existing phone should return error', () {
      final result = SahihValidator.phone(
        phone: '1234567890',
        existingPhones: ['1234567890', '0987654321'],
        alreadyExistsMessage: 'Phone already exists',
      );
      expect(result, 'Phone already exists');
    });

    test('Valid phone should return null', () {
      final result = SahihValidator.phone(phone: '1234567890');
      expect(result, null);
    });
  });

  group('Login Password Validation', () {
    test('Empty password should return error', () {
      final result = SahihValidator.loginPassword(
        password: '',
        emptyMessage: 'Password is required',
      );
      expect(result, 'Password is required');
    });

    test('Non-empty password should return null', () {
      final result = SahihValidator.loginPassword(password: 'password123');
      expect(result, null);
    });
  });

  group('Password Parts', () {
    test('Should split input into parts', () {
      final parts = SahihValidator.passwordParts('part1 part2 part3');
      expect(parts, ['part1', 'part2', 'part3']);
    });

    test('Empty input should return empty list', () {
      final parts = SahihValidator.passwordParts('');
      expect(parts, "Password is required.");
    });
  });

  group('Custom Validation', () {
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