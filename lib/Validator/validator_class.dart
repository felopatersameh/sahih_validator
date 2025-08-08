import '../Extensions/pattern_type.dart';
import 'email_validate.dart';
import 'phone_validate.dart';
import 'password_validate.dart';
import 'custom_validate.dart';

class SahihValidator {
  static String? email({
    required String email,
    String? emptyMessage,
    String? invalidFormatMessage,
    bool trimWhitespace = true,
    List<String>? existingEmails,
    String? alreadyExistsMessage,
  }) {
    return validateEmail(
      email: email,
      emptyMessage: emptyMessage,
      invalidFormatMessage: invalidFormatMessage,
      trimWhitespace: trimWhitespace,
      existingEmails: existingEmails,
      alreadyExistsMessage: alreadyExistsMessage,
    );
  }

  static String? phone({
    required String phone,
    String? emptyMessage,
    String? invalidFormatMessage,
    bool trimWhitespace = true,
    List<String>? existingPhones,
    String? alreadyExistsMessage,
  }) {
    return validatePhone(
      phone: phone,
      emptyMessage: emptyMessage,
      invalidFormatMessage: invalidFormatMessage,
      trimWhitespace: trimWhitespace,
      existingPhones: existingPhones,
      alreadyExistsMessage: alreadyExistsMessage,
    );
  }

  static String? loginPassword({
    required String password,
    String? emptyMessage,
  }) {
    return validateLoginPassword(
      password: password,
      emptyMessage: emptyMessage,
    );
  }

  static String? passwordParts(String input , { List<String>? commonPasswords}) {
    return validatePasswordParts( input: input, commonPasswords: commonPasswords );
  }

  static String? custom({
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
    return customValidate(
      value: value,
      title: title,
      trimWhitespace: trimWhitespace,
      isRequired: isRequired,
      minLength: minLength,
      maxLength: maxLength,
      pattern: pattern,
      patternType: patternType,
      allowOnlyNumbers: allowOnlyNumbers,
      allowOnlyLetters: allowOnlyLetters,
      emptyMessage: emptyMessage,
      minLengthMessage: minLengthMessage,
      maxLengthMessage: maxLengthMessage,
      invalidPatternMessage: invalidPatternMessage,
      invalidNumberMessage: invalidNumberMessage,
      invalidLettersMessage: invalidLettersMessage,
      customValidator: customValidator,
      existingValues: existingValues,
      alreadyExistsMessage: alreadyExistsMessage,
    );
  }
}