import '../Extensions/pattern_type.dart';

String? validatePhone({
  required String phone,
  String? emptyMessage,
  String? invalidFormatMessage,
  bool trimWhitespace = true,
  List<String>? existingPhones,
  String? alreadyExistsMessage,
}) {
  final input = trimWhitespace ? phone.trim() : phone;

  if (input.isEmpty) {
    return emptyMessage ?? "Please enter your phone number.";
  }

  if (!PatternType.phone.isValid(input)) {
    return invalidFormatMessage ??
        "The phone number is invalid. Please enter a valid 10–15 digit number.";
  }

  if (existingPhones != null && existingPhones.contains(input)) {
    return alreadyExistsMessage ?? "This phone number is already registered.";
  }

  return null;
}
