# SahihValidator 🔐

A comprehensive and powerful Flutter validation library that provides robust validation for emails, phone numbers, passwords, addresses, URLs, and custom fields with excellent form integration.

## Table of Contents 📋

- [Features](#features-)
- [Quick Start](#quick-start-)
- [Detailed Usage Guide](#detailed-usage-guide-)
  - [1. Email Validation](#1-email-validation-)
  - [2. Phone Number Validation](#2-phone-number-validation-)
  - [3. Password Validation](#3-password-validation-)
  - [4. Address Validation](#4-address-validation-)
  - [5. URL Validation](#5-url-validation-)
  - [6. Custom Validation](#6-custom-validation-️)
- [Common Parameters](#common-parameters-)
- [Form Integration](#form-integration-)
- [Best Practices](#best-practices-)
- [Contributing](#contributing-)
- [License](#license-)
- [Support](#support-)

## Features ✨

- **📧 Email Validation**: RFC-compliant email format validation with duplicate checking
- **📱 Phone Validation**: International phone number format validation (10-15 digits)
- **🔒 Password Validation**: Both simple login validation and comprehensive strength checking
- **🏠 Address Validation**: Detailed address validation with component requirements
- **🌐 URL Validation**: Asynchronous URL validation with domain verification options
- **⚙️ Custom Validation**: Flexible validation with multiple configurable rules
- **📝 Form Integration**: Perfect integration with Flutter's form validation system
- **🌍 Internationalization**: Customizable error messages for all validation types
- **🎯 Type Safety**: Full Dart type safety with comprehensive error handling

## Quick Start 🚀

Import the package:

```dart
import 'package:sahih_validator/sahih_validator.dart';
```

Basic usage example:

```dart
// Email validation
String? emailError = SahihValidator.email(email: "user@example.com");

// Phone validation
String? phoneError = SahihValidator.phone(phone: "+1234567890");

// Password strength validation
String? passwordError = SahihValidator.passwordParts("MySecureP@ssw0rd!");

// Custom validation
String? usernameError = SahihValidator.custom(
  value: "john_doe",
  minLength: 3,
  maxLength: 20,
  pattern: r'^[a-zA-Z0-9_]+$',
);
```

## Detailed Usage Guide 📖

### 1. Email Validation 📧

Email validation supports RFC-compliant format checking and duplicate detection:

```dart
String? emailError = SahihValidator.email(
  email: "user@example.com",
  emptyMessage: "Email is required",
  invalidFormatMessage: "Please enter a valid email address",
  trimWhitespace: true, // Remove leading/trailing spaces (default: true)
  existingEmails: ["admin@site.com", "user@site.com"], // Check for duplicates
  alreadyExistsMessage: "This email is already registered",
);
```

**Valid email formats:**

- `user@example.com`
- `user.name@domain.co.uk`
- `user+tag@example.org`
- `user123@test-domain.com`

**Invalid email formats:**

- `plainaddress` (missing @ and domain)
- `@domain.com` (missing username)
- `user@` (missing domain)
- `user@domain` (missing TLD)

**→ [View Implementation](lib/Validator/validator_class.dart#L54)** | **[View Tests](test/sahih_validator_test.dart#L8)**

### 2. Phone Number Validation 📱

Phone validation accepts international formats with 10-15 digits:

```dart
String? phoneError = SahihValidator.phone(
  phone: "+1234567890",
  emptyMessage: "Phone number is required",
  invalidFormatMessage: "Please enter a valid phone number (10-15 digits)",
  trimWhitespace: true,
  existingPhones: ["1234567890", "0987654321"], // Check for duplicates
  alreadyExistsMessage: "This phone number is already registered",
);
```

**Valid phone formats:**

- `1234567890` (10 digits)
- `+1234567890` (with country code)
- `123456789012345` (up to 15 digits)

**Invalid phone formats:**

- `123` (too short)
- `123-456-7890` (contains dashes)
- `(123) 456-7890` (contains spaces and parentheses)
- `abcdefghij` (contains letters)

**→ [View Implementation](lib/Validator/validator_class.dart#L100)** | **[View Tests](test/sahih_validator_test.dart#L130)**

### 3. Password Validation 🔒

#### Simple Login Password Validation

For login forms where you only need to check if password is not empty:

```dart
String? loginError = SahihValidator.loginPassword(
  password: "userpassword",
  emptyMessage: "Password is required to login",
);
```

**→ [View Implementation](lib/Validator/validator_class.dart#L127)** | **[View Tests](test/sahih_validator_test.dart#L287)**

#### Password Strength Validation

For registration forms with comprehensive strength checking:

```dart
String? strengthError = SahihValidator.passwordParts(
  "MySecureP@ssw0rd!",
  commonPasswords: ["companyname", "oldpassword"], // Optional custom weak passwords
);
```

**Password strength requirements:**

- Minimum 8 characters
- At least one uppercase letter (A-Z)
- At least one lowercase letter (a-z)
- At least one digit (0-9)
- Cannot be only numbers
- Cannot be a common/weak password
- Must have sufficient entropy (complexity)

**→ [View Implementation](lib/Validator/validator_class.dart#L166)** | **[View Tests](test/sahih_validator_test.dart#L295)**

### 4. Address Validation 🏠

Comprehensive address validation with component requirements:

```dart
String? addressError = SahihValidator.address(
  address: "123 Main Street, Springfield, USA",
  requireStreetNumber: true,
  requireStreetName: true,
  requireCity: true,
  requireCountry: true,
  minLength: 15,
  maxLength: 200,
  forbiddenWords: ["PO Box"], // Don't allow P.O. boxes
  missingStreetNumberMessage: "Address must include a street number",
  missingCountryMessage: "Address must include a country",
);
```

**→ [View Implementation](lib/Validator/validator_class.dart#L280)** | **[View Tests](test/sahih_validator_test.dart#L340)**

### 5. URL Validation 🌐

Asynchronous URL validation with multiple return types:

```dart
// Get validation message
String message = await SahihValidator.urlAsync<String>("https://example.com");

// Get boolean result
bool isValid = await SahihValidator.urlAsync<bool>("https://example.com");

// Get complete result with parsed data
UrlValidationResult result = await SahihValidator.urlAsync("https://example.com/path?q=1");
if (result.isValid) {
  print("Domain: ${result.data?.domain}");
  print("Protocol: ${result.data?.protocol}");
  print("Path: ${result.data?.path}");
}

// Advanced options
bool isValidRestricted = await SahihValidator.urlAsync<bool>(
  "https://example.com",
  allowedDomains: ["example.com", "trusted-site.org"],
  allowedSchemes: ["https"], // Only HTTPS allowed
  checkDomainExists: false, // Skip DNS lookup for performance
);
```

**→ [View Implementation](lib/Validator/validator_class.dart#L383)** | **[View Tests](test/sahih_validator_test.dart#L451)**

### 6. Custom Validation ⚙️

Flexible validation with multiple configurable rules:

```dart
// Username validation example
String? usernameError = SahihValidator.custom(
  value: "john_doe123",
  title: "Username",
  minLength: 3,
  maxLength: 20,
  pattern: r'^[a-zA-Z0-9_]+$', // Alphanumeric and underscore only
  existingValues: ["admin", "root", "john_doe123"],
  customValidator: (value) {
    if (value.startsWith('_')) return "Username cannot start with underscore";
    return null;
  },
);

// Product code validation example
String? productCodeError = SahihValidator.custom(
  value: "PRD-1234",
  title: "Product Code",
  pattern: r'^PRD-\d{4}$',
  invalidPatternMessage: "Product code must be in format PRD-XXXX (e.g., PRD-1234)",
);
```

**→ [View Implementation](lib/Validator/validator_class.dart#L205)** | **[View Tests](test/sahih_validator_test.dart#L390)**

## Common Parameters 🔧

Many validation methods share these common parameters:

### trimWhitespace (bool)

**Default**: `true`

Removes leading and trailing whitespace from input before validation:

```dart
// With trimming (default)
SahihValidator.email(
  email: "  user@example.com  ", // Becomes "user@example.com"
  trimWhitespace: true,
); // Returns null (valid)

// Without trimming
SahihValidator.email(
  email: "  user@example.com  ", // Stays "  user@example.com  "
  trimWhitespace: false,
); // Returns error (invalid format)
```

### existingValues/existingEmails/existingPhones (`List<String>?`)

**Default**: `null`

Lists of values that already exist in your system. Validation fails if input matches any existing value:

```dart
SahihValidator.email(
  email: "admin@site.com",
  existingEmails: ["admin@site.com", "user@site.com"],
  alreadyExistsMessage: "This email is already registered",
); // Returns "This email is already registered"
```

### Custom Error Messages

All validation methods accept custom error message parameters:

- `emptyMessage`: When the field is empty
- `invalidFormatMessage`: When the format is invalid
- `alreadyExistsMessage`: When the value already exists
- Method-specific messages (e.g., `minLengthMessage`, `maxLengthMessage`)

## Form Integration 📝

SahihValidator is designed to work seamlessly with Flutter's form validation system:

### Basic Form Integration

```dart
TextFormField(
  validator: (value) => SahihValidator.email(
    email: value ?? '',
    emptyMessage: "Email is required",
  ),
  decoration: InputDecoration(labelText: "Email"),
)
```

## Best Practices 💡

1. **Use appropriate validation for context**:
   - Use `loginPassword` for login forms
   - Use `passwordParts` for registration forms

2. **Provide helpful error messages**:
   - Customize error messages to guide users on how to fix validation errors
   - Be specific about requirements (e.g., "Password must be at least 8 characters")

3. **Handle existing values**:
   - Always check against existing values to prevent duplicates in your system
   - Use meaningful duplicate error messages

4. **Use trimWhitespace**:
   - Keep the default `trimWhitespace: true` unless you specifically need to preserve whitespace
   - This helps handle accidental user input with spaces

5. **Combine validations**:
   - Use multiple validation methods for complex forms to ensure data quality
   - Consider using `custom` validation for business-specific rules

6. **Performance considerations**:
   - For URL validation, avoid `checkDomainExists: true` unless necessary (requires network call)
   - Cache existing values lists when possible to avoid repeated database queries

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request.

## License 📄

MIT License

## Support 💬

For questions or support, please open an issue on GitHub.
