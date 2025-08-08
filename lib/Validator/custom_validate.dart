import '../Extensions/pattern_type.dart';

String? customValidate({
  required String value,
  String? title,
  bool trimWhitespace = true,
  bool isRequired = true,
  int? minLength,
  int? maxLength,
  String? pattern,
  PatternType? patternType,
  bool allowOnlyNumbers = false,
  bool allowOnlyLetters = false,
  String? emptyMessage,
  String? minLengthMessage,
  String? maxLengthMessage,
  String? invalidPatternMessage,
  String? invalidNumberMessage,
  String? invalidLettersMessage,
  String? Function(String value)? customValidator,
  List<String>? existingValues,
  String? alreadyExistsMessage,
}) {
  final String fieldName = title ?? "Field";
  final String input = trimWhitespace ? value.trim() : value;

  if (isRequired && input.isEmpty) {
    return emptyMessage ?? "Please enter $fieldName.";
  }

  if (!isRequired && input.isEmpty) {
    return null;
  }

  if (existingValues != null && existingValues.contains(input)) {
    return alreadyExistsMessage ?? "$fieldName already exists.";
  }

  if (minLength != null && input.length < minLength) {
    return minLengthMessage ?? "$fieldName must be at least $minLength characters long.";
  }

  if (maxLength != null && input.length > maxLength) {
    return maxLengthMessage ?? "$fieldName must be at most $maxLength characters long.";
  }

  if (allowOnlyNumbers && !RegExp(r'^\d+$').hasMatch(input)) {
    return invalidNumberMessage ?? "$fieldName must contain only numbers.";
  }

  if (allowOnlyLetters && !RegExp(r'^[a-zA-Z]+$').hasMatch(input)) {
    return invalidLettersMessage ?? "$fieldName must contain only letters.";
  }

  if (patternType != null && !patternType.isValid(input)) {
    return invalidPatternMessage ?? "$fieldName format is invalid.";
  }

  if (pattern != null && !RegExp(pattern).hasMatch(input)) {
    return invalidPatternMessage ?? "$fieldName format is invalid.";
  }

  if (customValidator != null) {
    return customValidator(input);
  }

  return null;
}
