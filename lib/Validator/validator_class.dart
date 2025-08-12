import '../Extensions/pattern_type.dart';
import 'adress_validate.dart';
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

  static String? address({
    required String address,
    String? title,
    String? emptyMessage,
    bool trimWhitespace = true,
    List<String>? existingAddresses,
    String? alreadyExistsMessage,
    bool isRequired = true,
    int minLength = 10,
    int maxLength = 200,
    bool requireStreetNumber = false,
    bool requireStreetName = true,
    bool requireCity = false,
    bool requireCountry = false,
    bool allowSpecialChars = true,
    bool allowNumbers = true,
    bool allowLetters = true,
    List<String>? forbiddenWords,
    List<String>? requiredWords,
    String? minLengthMessage,
    String? maxLengthMessage,
    String? missingStreetNumberMessage,
    String? missingStreetNameMessage,
    String? missingCityMessage,
    String? missingCountryMessage,
    String? invalidSpecialCharsMessage,
    String? invalidNumbersMessage,
    String? invalidLettersMessage,
    String? forbiddenWordsMessage,
    String? requiredWordsMessage,
    
  }) {
    return validateAddress(
      address: address,
      emptyMessage: emptyMessage,
      trimWhitespace: trimWhitespace,
      existingAddresses: existingAddresses,
      alreadyExistsMessage: alreadyExistsMessage,
      isRequired: isRequired,
      minLength: minLength,
      maxLength: maxLength,
      requireStreetNumber: requireStreetNumber,
      requireStreetName: requireStreetName,
      requireCity: requireCity,
      requireCountry: requireCountry,
      allowSpecialChars: allowSpecialChars,
      allowNumbers: allowNumbers,
      allowLetters: allowLetters,
      forbiddenWords: forbiddenWords,
      requiredWords: requiredWords,
      minLengthMessage: minLengthMessage,
      maxLengthMessage: maxLengthMessage,
      missingStreetNumberMessage: missingStreetNumberMessage,
      missingStreetNameMessage: missingStreetNameMessage,
      missingCityMessage: missingCityMessage,
      missingCountryMessage: missingCountryMessage,
      invalidSpecialCharsMessage: invalidSpecialCharsMessage,
      invalidNumbersMessage: invalidNumbersMessage,
      invalidLettersMessage: invalidLettersMessage,
      forbiddenWordsMessage: forbiddenWordsMessage,
      requiredWordsMessage: requiredWordsMessage,
      title: title,
    );
  }
}