import 'package:flutter_test/flutter_test.dart';
import 'package:sahih_validator/sahih_validator.dart';

void urlTest() {
  return group('URL Validation', () {
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
