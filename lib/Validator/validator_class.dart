import '../Extensions/pattern_type.dart';
import 'adress_validate.dart';
import 'date_of_birth_validator.dart';
import 'email_validate.dart';
import 'phone_validate.dart';
import 'password_validate.dart';
import 'custom_validate.dart';
import 'url_validate.dart';

/// A comprehensive validation library for Flutter applications.
///
/// Provides static methods for validating emails, phone numbers, passwords,
/// addresses, URLs, and custom fields. All methods return `null` for valid input
/// or an error message string for invalid input.
/// A collection of static validation methods for common input types.
///
/// This class provides validation for:
/// - Email addresses
/// - Phone numbers
/// - Passwords
/// - Addresses
/// - URLs
/// - Custom validation rules
/// A comprehensive validator for common input types in Flutter applications.
///
/// Provides static methods for validating:
/// - Email addresses
/// - Phone numbers
/// - Passwords
/// - Addresses
/// - URLs
/// - Custom input patterns
///
/// All methods return `null` if validation passes, or a String error message
/// if validation fails.
class SahihValidator {
  /// Validates an email address format and checks against existing emails.
  ///
  /// Returns `null` if valid, or an error message if invalid.
  ///
  /// Parameters:
  /// * [email]: The email address to validate
  /// * [emptyMessage]: Custom message when empty
  /// * [invalidFormatMessage]: Custom message for invalid format
  /// * [trimWhitespace]: Whether to trim whitespace (default: true)
  /// * [existingEmails]: List of existing emails to check against
  /// * [alreadyExistsMessage]: Custom message when email already exists
  /// Validates an email address against standard format requirements.
  ///
  /// Parameters:
  /// - [email]: The email address to validate
  /// - [emptyMessage]: Custom message for empty input (default: 'Please enter your email.')
  /// - [invalidFormatMessage]: Custom message for invalid format (default: 'The email address is badly formatted.')
  /// - [trimWhitespace]: Whether to trim whitespace from input (default: true)
  /// - [existingEmails]: List of existing emails to check against for uniqueness
  /// - [alreadyExistsMessage]: Custom message for duplicate emails (default: 'This email is already registered.')
  ///
  /// Returns `null` if valid, or an error message if invalid.
  ///
  /// Example:
  /// ```dart
  /// final error = SahihValidator.email(
  ///   email: 'user@example.com',
  ///   existingEmails: ['admin@example.com'],
  /// );
  /// if (error != null) {
  ///   print('Validation error: $error');
  /// }
  /// ```
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

  /// Validates a phone number format and checks against existing phone numbers.
  ///
  /// Accepts phone numbers with 10-15 digits, optionally starting with '+'.
  /// Returns `null` if valid, or an error message if invalid.
  ///
  /// Parameters:
  /// * [phone]: The phone number to validate
  /// * [emptyMessage]: Custom message when empty
  /// * [invalidFormatMessage]: Custom message for invalid format
  /// * [trimWhitespace]: Whether to trim whitespace (default: true)
  /// * [existingPhones]: List of existing phone numbers to check against
  /// * [alreadyExistsMessage]: Custom message when phone already exists
  /// Validates a phone number against basic format requirements.
  ///
  /// Accepts numbers with optional '+' prefix (10-15 digits total).
  ///
  /// Parameters:
  /// - [phone]: The phone number to validate
  /// - [emptyMessage]: Custom message for empty input (default: 'Please enter your phone number.')
  /// - [invalidFormatMessage]: Custom message for invalid format (default: 'The phone number is invalid...')
  /// - [trimWhitespace]: Whether to trim whitespace from input (default: true)
  /// - [existingPhones]: List of existing numbers to check against
  /// - [alreadyExistsMessage]: Custom message for duplicates (default: 'This phone number is already registered.')
  ///
  /// Returns `null` if valid, or an error message if invalid.
  ///
  /// Example:
  /// ```dart
  /// final error = SahihValidator.phone(
  ///   phone: '+1234567890',
  ///   trimWhitespace: false, // Preserve formatting
  /// );
  /// ```
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

  /// Validates a login password by checking if it's not empty.
  ///
  /// Simple validation for login forms. For password strength validation
  /// during registration, use [passwordParts] instead.
  ///
  /// Parameters:
  /// * [password]: The password to validate
  /// * [emptyMessage]: Custom message when empty
  /// Validates that a password is not empty (basic login validation).
  ///
  /// Parameters:
  /// - [password]: The password to validate
  /// - [emptyMessage]: Custom message for empty input (default: 'Please enter your password.')
  ///
  /// Returns `null` if valid (non-empty), or an error message if invalid.
  ///
  /// Example:
  /// ```dart
  /// final error = SahihValidator.loginPassword(password: input);
  /// ```
  static String? loginPassword({
    required String password,
    String? emptyMessage,
  }) {
    return validateLoginPassword(
      password: password,
      emptyMessage: emptyMessage,
    );
  }

  /// Validates password strength for new password creation.
  ///
  /// Performs comprehensive strength validation including length, character diversity,
  /// and checks against common passwords. Returns `null` for strong passwords or
  /// detailed error messages listing all validation failures.
  ///
  /// Requirements: 8+ characters, uppercase, lowercase, digit, not only numbers,
  /// not a common password, sufficient entropy.
  ///
  /// Parameters:
  /// * [input]: The password to validate
  /// * [commonPasswords]: Optional list of passwords to reject
  /// Validates password strength with multiple requirements.
  ///
  /// Checks for:
  /// - Minimum 8 characters
  /// - At least one uppercase letter
  /// - At least one lowercase letter
  /// - At least one digit
  /// - Not consisting of only numbers
  /// - Not in common passwords list
  ///
  /// Parameters:
  /// - [input]: The password to validate
  /// - [commonPasswords]: Optional list of banned/common passwords
  ///
  /// Returns concatenated error messages for all failed checks, or `null` if valid.
  ///
  /// Example:
  /// ```dart
  /// final error = SahihValidator.passwordParts(
  ///   'weak',
  ///   commonPasswords: ['password', '123456']
  /// );
  /// ```
  static String? passwordParts(String input, {List<String>? commonPasswords}) {
    return validatePasswordParts(
      input: input,
      commonPasswords: commonPasswords,
    );
  }

  /// Provides flexible custom validation with multiple configurable rules.
  ///
  /// The most versatile validation method, allowing combination of multiple
  /// validation rules. Perfect for usernames, product codes, or custom fields.
  ///
  /// Validation order: required check, existing values, length, character restrictions,
  /// pattern matching, custom function.
  ///
  /// Parameters:
  /// * [value]: The input value to validate
  /// * [title]: Field name for error messages (default: "Field")
  /// * [trimWhitespace]: Whether to trim whitespace (default: true)
  /// * [isRequired]: Whether the field is required (default: true)
  /// * [minLength], [maxLength]: Length constraints
  /// * [pattern]: Custom regex pattern
  /// * [patternType]: Predefined pattern from PatternType enum
  /// * [allowOnlyNumbers], [allowOnlyLetters]: Character type restrictions
  /// * [customValidator]: Custom validation function
  /// * [existingValues]: List of existing values to check against
  /// * Various message parameters for customizing error messages
  /// Validates custom input with flexible validation rules.
  ///
  /// Parameters:
  /// - [value]: The value to validate
  /// - [title]: Field title for error messages
  /// - [trimWhitespace]: Whether to trim whitespace (default: true)
  /// - [isRequired]: Whether empty values are allowed (default: true)
  /// - [minLength]: Minimum allowed length
  /// - [maxLength]: Maximum allowed length
  /// - [pattern]: Custom regex pattern to validate against
  /// - [patternType]: Predefined pattern type (overrides [pattern] if both provided)
  /// - [allowOnlyNumbers]: Restrict to numeric characters only (default: false)
  /// - [allowOnlyLetters]: Restrict to alphabetic characters only (default: false)
  /// - [emptyMessage]: Custom empty validation message
  /// - [minLengthMessage]: Custom minimum length message
  /// - [maxLengthMessage]: Custom maximum length message
  /// - [invalidPatternMessage]: Custom invalid pattern message
  /// - [invalidNumberMessage]: Custom numbers-only violation message
  /// - [invalidLettersMessage]: Custom letters-only violation message
  /// - [customValidator]: Custom validation function for complex rules
  /// - [existingValues]: List of existing values for uniqueness check
  /// - [alreadyExistsMessage]: Custom duplicate value message
  ///
  /// Returns `null` if valid, or an error message if invalid.
  ///
  /// Example:
  /// ```dart
  /// // Validate username with custom rules
  /// final error = SahihValidator.custom(
  ///   value: username,
  ///   minLength: 4,
  ///   maxLength: 20,
  ///   allowOnlyLetters: true,
  ///   invalidLettersMessage: 'Username must contain only letters'
  /// );
  /// ```
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

  /// Validates physical addresses with comprehensive formatting and content rules.
  ///
  /// Provides detailed address validation including length constraints, component
  /// requirements (street number, street name, city, country), character type
  /// restrictions, and content filtering.
  ///
  /// Parameters:
  /// * [address]: The address string to validate
  /// * [title]: Field name for error messages (default: "Address")
  /// * [trimWhitespace]: Whether to trim whitespace (default: true)
  /// * [isRequired]: Whether the field is required (default: true)
  /// * [minLength], [maxLength]: Length constraints (default: 10-200)
  /// * [requireStreetNumber], [requireStreetName], [requireCity], [requireCountry]: Component requirements
  /// * [allowNumbers], [allowLetters], [allowSpecialChars]: Character type controls
  /// * [forbiddenWords], [requiredWords]: Content filtering
  /// * [existingAddresses]: List of existing addresses to check against
  /// * Various message parameters for customizing error messages
  /// Validates an address with comprehensive checks for structure and content.
  ///
  /// Parameters:
  /// - [address]: The address string to validate
  /// - [title]: Field title for error messages (default: 'Address')
  /// - [emptyMessage]: Custom empty validation message
  /// - [trimWhitespace]: Whether to trim whitespace (default: true)
  /// - [existingAddresses]: List of existing addresses for uniqueness check
  /// - [alreadyExistsMessage]: Custom duplicate address message
  /// - [isRequired]: Whether empty values are allowed (default: true)
  /// - [minLength]: Minimum allowed length (default: 10)
  /// - [maxLength]: Maximum allowed length (default: 200)
  /// - [requireStreetNumber]: Whether to require a street number (default: false)
  /// - [requireStreetName]: Whether to require a street name (default: true)
  /// - [requireCity]: Whether to require a city name (default: false)
  /// - [requireCountry]: Whether to require a country (default: false)
  /// - [allowSpecialChars]: Whether special chars are allowed (default: true)
  /// - [allowNumbers]: Whether numbers are allowed (default: true)
  /// - [allowLetters]: Whether letters are allowed (default: true)
  /// - [forbiddenWords]: List of prohibited words/phrases
  /// - [requiredWords]: List of required words/phrases
  /// - [minLengthMessage]: Custom minimum length message
  /// - [maxLengthMessage]: Custom maximum length message
  /// - [missingStreetNumberMessage]: Custom missing street number message
  /// - [missingStreetNameMessage]: Custom missing street name message
  /// - [missingCityMessage]: Custom missing city message
  /// - [missingCountryMessage]: Custom missing country message
  /// - [invalidSpecialCharsMessage]: Custom invalid special chars message
  /// - [invalidNumbersMessage]: Custom invalid numbers message
  /// - [invalidLettersMessage]: Custom invalid letters message
  /// - [forbiddenWordsMessage]: Custom forbidden words message
  /// - [requiredWordsMessage]: Custom required words message
  ///
  /// Returns `null` if valid, or an error message if invalid.
  ///
  /// Example:
  /// ```dart
  /// final error = SahihValidator.address(
  ///   address: '123 Main St, Springfield',
  ///   requireCity: true,
  ///   requireCountry: true
  /// );
  /// ```
  static String? address({
    required String address,
    String? title = "Address",
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

  /// Asynchronously validates URLs with comprehensive format and domain checking.
  ///
  /// Provides advanced URL validation including format verification, scheme restrictions,
  /// domain whitelisting, and optional DNS lookup. Return type is generic:
  /// * `String`: Returns validation message
  /// * `bool`: Returns true/false for validity
  /// * `UrlValidationResult`: Returns complete result with parsed URL data
  ///
  /// Parameters:
  /// * [url]: The URL string to validate
  /// * [allowRelative]: Whether to allow relative URLs (default: false)
  /// * [allowedSchemes]: List of allowed URL schemes
  /// * [allowedDomains]: List of allowed domains
  /// * [normalize]: Whether to normalize the URL (default: true)
  /// * [checkDomainExists]: Whether to perform DNS lookup (default: false, can be slow)
  /// Validates a URL with optional DNS verification and format checks.
  ///
  /// Parameters:
  /// - [url]: The URL to validate
  /// - [allowRelative]: Whether to allow relative URLs (default: false)
  /// - [allowedSchemes]: List of allowed URL schemes (e.g. ['http', 'https'])
  /// - [allowedDomains]: List of allowed domains (e.g. ['example.com'])
  /// - [normalize]: Whether to normalize the URL (default: true)
  /// - [checkDomainExists]: Whether to verify domain exists via DNS (default: false)
  ///
  /// Generic type [T] can be:
  /// - `String`: Returns error message or 'URL is valid'
  /// - `bool`: Returns true/false
  /// - `UrlValidationResult`: Returns detailed validation result object
  ///
  /// Example:
  /// ```dart
  /// // Simple boolean check
  /// final isValid = await SahihValidator.urlAsync<bool>('https://example.com');
  ///
  /// // Detailed result
  /// final result = await SahihValidator.urlAsync<UrlValidationResult>(
  ///   'https://example.com/path',
  ///   allowedDomains: ['example.com']
  /// );
  /// ```
  static Future<T> urlAsync<T>(
    String url, {
    bool allowRelative = false,
    List<String>? allowedSchemes,
    List<String>? allowedDomains,
    bool normalize = true,
    bool checkDomainExists = false,
  }) async {
    return await isValidUrlAsync<T>(
      url,
      allowRelative: allowRelative,
      allowedSchemes: allowedSchemes,
      allowedDomains: allowedDomains,
      normalize: normalize,
      checkDomainExists: checkDomainExists,
    );
  }

  ///
  static String? dateOfBirth({
    required String dob,
    String format = "yyyy-MM-dd",
    int minAgeYears = 18,
    int maxAgeYears = 120,
    int? minAgeDays,
    bool useUtc = false,
    String? invalidFormatMessage,
    String? futureDateMessage,
    String? tooYoungMessage,
    String? tooOldMessage,
  }) {
    return DateOfBirthValidator.validate(
      dob,
      format: format,
      minAgeYears: minAgeYears,
      maxAgeYears: maxAgeYears,
      minAgeDays: minAgeDays,
      invalidFormatMessage: invalidFormatMessage,
      futureDateMessage: futureDateMessage,
      tooYoungMessage: tooYoungMessage,
      tooOldMessage: tooOldMessage,
      useUtc: useUtc,
    );
  }
}
