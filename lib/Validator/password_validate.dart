import 'dart:math';

import '../Extensions/password_validate_extension.dart';

/// Validates a password for login purposes by checking if it's not empty.
///
/// Simple validation for login forms. For password strength validation
/// during registration, use [validatePasswordParts] instead.
///
/// Parameters:
/// * [password]: The password to validate
/// * [emptyMessage]: Custom message when empty
String? validateLoginPassword({
  required String password,
  String? emptyMessage,
}) {
  if (password.isEmpty) {
    return emptyMessage ?? "Please enter your password.";
  }
  return null;
}

/// Validates password strength with comprehensive security requirements.
///
/// Performs detailed password strength analysis including character diversity,
/// length validation, entropy calculation, and checks against common weak passwords.
///
/// Requirements: 8+ characters, uppercase, lowercase, digit, not only numbers,
/// not a common password, sufficient entropy.
///
/// Returns `null` for strong passwords, or detailed error messages listing all
/// validation failures (separated by newlines).
///
/// Parameters:
/// * [input]: The password to validate
/// * [commonPasswords]: Optional list of passwords to reject
String? validatePasswordParts({
  required String input,
  List<String>? commonPasswords,
}) {
  final errors = <String>[];

  final weakList = commonPasswords ?? weakPasswords;

  if (input.isEmpty) {
    errors.add("Password is required.");
    return errors.join('\n');
  }

  if (weakList.contains(input)) {
    errors.add("Password is too common.");
    return errors.join('\n');
  }

  if (input.length < 8) {
    errors.add("At least 8 characters required.");
  }

  if (!RegExp(r'[A-Z]').hasMatch(input)) {
    errors.add("One uppercase letter required.");
  }

  if (!RegExp(r'[a-z]').hasMatch(input)) {
    errors.add("One lowercase letter required.");
  }

  if (!RegExp(r'[0-9]').hasMatch(input)) {
    errors.add("One digit required.");
  }

  if (RegExp(r'^[0-9]+$').hasMatch(input)) {
    errors.add("Password cannot be only numbers.");
  }

  final charsetSize = calculateCharsetSize(input);
  final entropy = input.length * log(charsetSize) / log(2);

  if (entropy < 60) {
    errors.add("Password is too weak. Add more complexity.");
  }

  return errors.isEmpty ? null : errors.join('\n');
}
