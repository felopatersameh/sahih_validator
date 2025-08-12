import '../Extensions/pattern_type.dart';

/// Validates an email address format and checks for duplicates.
///
/// Performs RFC-compliant email format validation and optional duplicate checking.
/// Returns `null` if valid, or an error message if invalid.
///
/// Parameters:
/// * [email]: The email address to validate
/// * [emptyMessage]: Custom message when empty
/// * [invalidFormatMessage]: Custom message for invalid format
/// * [trimWhitespace]: Whether to trim whitespace (default: true)
/// * [existingEmails]: List of existing emails to check against
/// * [alreadyExistsMessage]: Custom message when email already exists
String? validateEmail({
  required String email,
  String? emptyMessage,
  String? invalidFormatMessage,
  bool trimWhitespace = true,
  List<String>? existingEmails,
  String? alreadyExistsMessage,
}) {
  final String input = trimWhitespace ? email.trim() : email;

  if (input.isEmpty) {
    return emptyMessage ?? "Please enter your email.";
  }

  if (!PatternType.email.isValid(input)) {
    return invalidFormatMessage ?? "The email address is badly formatted.";
  }

  if (existingEmails != null && existingEmails.contains(input)) {
    return alreadyExistsMessage ?? "This email is already registered.";
  }

  return null;
}
