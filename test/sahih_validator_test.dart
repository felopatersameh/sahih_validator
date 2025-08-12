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

  group('Phone Validation', () {
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

  group('Password Validation', () {
    test('Empty password should return error', () {
      final result = SahihValidator.loginPassword(password: '');
      expect(result, 'Please enter your password.');
    });

    test('Non-empty password should return null', () {
      final result = SahihValidator.loginPassword(password: 'password');
      expect(result, null);
    });

    test('Common password check', () {
      expect(
        SahihValidator.passwordParts('password', commonPasswords: ['password']),
        'Password is too common.',
      );
    });
  });

  group('Address Validation', () {
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

  group('URL Validation', () {
    test('Empty URL should return error', () async {
      final result = await SahihValidator.urlAsync<String>('');
      expect(result, 'URL is required');
    });

    test('Invalid URL format', () async {
      final result = await SahihValidator.urlAsync<String>('://chatgpt.com');
      expect(result, 'URL format is invalid');
    });

    test('Valid URL should return null for bool type', () async {
      final result = await SahihValidator.urlAsync<bool>("https://chatgpt.com");
      expect(result, true);
    });

    test('Domain whitelisting', () async {
      final result = await SahihValidator.urlAsync<String>(
        'https://other.com',
        allowedDomains: ['example.com'],
      );
      expect(result, contains('is not allowed'));
    });

    test('Relative URL handling', () async {
      final result = await SahihValidator.urlAsync<String>(
        '/path',
        allowRelative: true,
      );
      expect(result, 'Relative URL is valid');
    });
  });

  group('Common Parameters', () {
    test('trimWhitespace behavior', () {
      // Test trimWhitespace in email validation
      expect(
        SahihValidator.email(
          email: '  test@example.com  ',
          trimWhitespace: true,
        ),
        null,
      );

      // Test trimWhitespace in phone validation
      expect(
        SahihValidator.phone(phone: '  1234567890  ', trimWhitespace: true),
        null,
      );
    });
  });

  group('Common Parameters', () {
    test('trimWhitespace behavior', () {
      expect(
        SahihValidator.email(email: '  test@example.com  ', trimWhitespace: true),
        null,
      );
      expect(
        SahihValidator.phone(phone: '  1234567890  ', trimWhitespace: true),
        null,
      );
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

  group('URL Validation', () {
    test('Empty URL should return error message', () async {
      final result = await SahihValidator.urlAsync<String>('');
      expect(result, 'URL is required');
    });

    test('Empty URL should return false for bool', () async {
      final result = await SahihValidator.urlAsync<bool>('');
      expect(result, false);
    });

    test('Empty URL should return UrlValidationResult', () async {
      final result = await SahihValidator.urlAsync<UrlValidationResult>('');
      expect(result.isValid, false);
      expect(result.message, 'URL is required');
      expect(result.data, null);
    });

    test('URL without scheme should return error', () async {
      final result = await SahihValidator.urlAsync<String>('www.example.com');
      expect(result, 'URL must start with http:// or https://');
    });

    test('Valid HTTP URL should return success', () async {
      final result = await SahihValidator.urlAsync<bool>(
        'http://www.example.com',
      );
      expect(result, true);
    });

    test('Valid HTTPS URL should return success', () async {
      final result = await SahihValidator.urlAsync<bool>(
        'https://www.example.com',
      );
      expect(result, true);
    });

    test('Valid URL should return complete UrlValidationResult', () async {
      final result = await SahihValidator.urlAsync<UrlValidationResult>(
        'https://www.example.com/path?query=value#fragment',
      );
      expect(result.isValid, true);
      expect(result.message, 'URL is valid');
      expect(result.data, isNotNull);
      expect(result.data!.protocol, 'https');
      expect(result.data!.host, 'www.example.com');
      expect(result.data!.domain, 'example.com');
      expect(result.data!.path, '/path');
      expect(result.data!.query, 'query=value');
      expect(result.data!.fragment, 'fragment');
    });

    test('Relative URL should be valid when allowed', () async {
      final result = await SahihValidator.urlAsync<bool>(
        '/relative/path',
        allowRelative: true,
      );
      expect(result, true);
    });

    test('Relative URL should be invalid when not allowed', () async {
      final result = await SahihValidator.urlAsync<String>(
        '/relative/path',
        allowRelative: false,
      );
      expect(result, 'URL must start with http:// or https://');
    });

    test('URL with disallowed scheme should return error', () async {
      final result = await SahihValidator.urlAsync<String>(
        'ftp://example.com',
        allowedSchemes: ['http', 'https'],
      );
      expect(result, "Scheme 'ftp' is not allowed");
    });

    test('URL with allowed scheme should be valid', () async {
      final result = await SahihValidator.urlAsync<bool>(
        'https://example.com',
        allowedSchemes: ['http', 'https'],
      );
      expect(result, true);
    });

    test('URL with disallowed domain should return error', () async {
      final result = await SahihValidator.urlAsync<String>(
        'https://badsite.com',
        allowedDomains: ['example.com', 'google.com'],
      );
      expect(result, "Domain 'badsite.com' is not allowed");
    });

    test('URL with allowed domain should be valid', () async {
      final result = await SahihValidator.urlAsync<bool>(
        'https://example.com',
        allowedDomains: ['example.com', 'google.com'],
      );
      expect(result, true);
    });

    test('Malformed URL should return error', () async {
      final result = await SahihValidator.urlAsync<String>('not-a-url://');
      expect(result, 'URL must have a valid domain');
    });

    test('URL without domain should return error', () async {
      final result = await SahihValidator.urlAsync<String>('https://');
      expect(result, 'URL must have a valid domain');
    });

    test('URL normalization should work', () async {
      final result = await SahihValidator.urlAsync<UrlValidationResult>(
        'https://example.com/',
        normalize: true,
      );
      expect(result.data!.fullUrl, 'https://example.com');
    });

    test('URL without normalization should preserve original', () async {
      final result = await SahihValidator.urlAsync<UrlValidationResult>(
        'https://example.com/',
        normalize: false,
      );
      expect(result.data!.fullUrl, 'https://example.com/');
    });

    test('URL with port should be parsed correctly', () async {
      final result = await SahihValidator.urlAsync<UrlValidationResult>(
        'https://example.com:8080/path',
      );
      expect(result.data!.port, 8080);
      expect(result.data!.host, 'example.com');
    });

    test('URL without port should have null port', () async {
      final result = await SahihValidator.urlAsync<UrlValidationResult>(
        'https://example.com/path',
      );
      expect(result.data!.port, null);
    });
  });
}
