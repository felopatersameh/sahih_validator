import '../Extensions/pattern_type.dart';

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
