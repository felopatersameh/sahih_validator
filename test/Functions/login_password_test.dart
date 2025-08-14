import 'package:flutter_test/flutter_test.dart';
import 'package:sahih_validator/sahih_validator.dart';

void loginPasswordTest() {
  return group('Login Password Validation', () {
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
}
