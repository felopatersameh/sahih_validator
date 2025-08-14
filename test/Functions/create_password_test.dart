import 'package:flutter_test/flutter_test.dart';
import 'package:sahih_validator/sahih_validator.dart';

void createPasswordTest() {
  return group('Password Validation', () {
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
}
