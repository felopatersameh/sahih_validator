import 'package:flutter_test/flutter_test.dart';
import 'package:sahih_validator/sahih_validator.dart';

void emailTest() {
  return group('Email Validation', () {
    test('Empty email should return error', () {
      final result = SahihValidator.email(
        email: '',
        emptyMessage: 'Email is required',
      );
      expect(result, 'Email is required');
    });

    test('Empty email with default message', () {
      final result = SahihValidator.email(email: '');
      expect(result, 'Please enter your email.');
    });

    test('Email with only whitespace should return error when trimmed', () {
      final result = SahihValidator.email(email: '   ', trimWhitespace: true);
      expect(result, 'Please enter your email.');
    });

    test('Email with whitespace should be valid when not trimmed', () {
      final result = SahihValidator.email(
        email: '   valid@test.com   ',
        trimWhitespace: false,
      );
      expect(result, 'The email address is badly formatted.');
    });

    test('Email with whitespace should be valid when trimmed', () {
      final result = SahihValidator.email(
        email: '   valid@test.com   ',
        trimWhitespace: true,
      );
      expect(result, null);
    });

    test('Invalid email format should return error', () {
      final result = SahihValidator.email(
        email: 'invalid-email',
        invalidFormatMessage: 'Invalid email format',
      );
      expect(result, 'Invalid email format');
    });

    test('Invalid email format with default message', () {
      final result = SahihValidator.email(email: 'invalid-email');
      expect(result, 'The email address is badly formatted.');
    });

    test('Various invalid email formats', () {
      final invalidEmails = [
        'plainaddress',
        '@missingdomain.com',
        'missing@.com',
        'missing@domain',
        'spaces @domain.com',
        'double@@domain.com',
        'trailing.dot@domain.com.',
        'invalid.domain@.com',
      ];

      for (final email in invalidEmails) {
        final result = SahihValidator.email(email: email);
        expect(
          result,
          'The email address is badly formatted.',
          reason: 'Email "$email" should be invalid',
        );
      }
    });

    test('Valid email formats', () {
      final validEmails = [
        'test@example.com',
        'user.name@domain.co.uk',
        'user123@test-domain.com',
        'a@b.co',
        'very.long.email.address@very-long-domain-name.com',
      ];

      for (final email in validEmails) {
        final result = SahihValidator.email(email: email);
        expect(result, null, reason: 'Email "$email" should be valid');
      }
    });

    test('Existing email should return error', () {
      final result = SahihValidator.email(
        email: 'existing@test.com',
        existingEmails: ['existing@test.com', 'user@test.com'],
        alreadyExistsMessage: 'Email already exists',
      );
      expect(result, 'Email already exists');
    });

    test('Existing email with default message', () {
      final result = SahihValidator.email(
        email: 'existing@test.com',
        existingEmails: ['existing@test.com'],
      );
      expect(result, 'This email is already registered.');
    });

    test('Case sensitivity in existing emails', () {
      final result = SahihValidator.email(
        email: 'Test@Example.com',
        existingEmails: ['test@example.com'],
      );
      expect(result, null); // Should be case sensitive
    });

    test('Valid email should return null', () {
      final result = SahihValidator.email(email: 'valid@test.com');
      expect(result, null);
    });

    test('Empty existing emails list should not cause error', () {
      final result = SahihValidator.email(
        email: 'test@example.com',
        existingEmails: [],
      );
      expect(result, null);
    });
  });
}
