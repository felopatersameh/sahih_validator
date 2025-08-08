# SahihValidator 🔐

A comprehensive and easy-to-use Flutter validation library supporting both Arabic and English languages.

## Description

SahihValidator is a powerful and flexible package designed specifically for Flutter developers to simplify data validation processes. The library supports email, phone number, password, and custom input validation with full support for Arabic language messages.

## Features ✨

- **Easy to Use**: Simple and straightforward API with no complexity
- **Secure**: Strict data validation to protect your application
- **Flexible**: Extensive customization options to suit all needs
- **Extensible**: Easy to add custom validation rules

## Usage 📝

### 1. Email Validation

```dart
// Basic email validation
String? emailError = SahihValidator.email(
  email: "test@example.com", // Email to validate
  emptyMessage: "Email is required", // Message when field is empty
  invalidFormatMessage: "Invalid email format", // Message for invalid format
  trimWhitespace: true, // Remove leading/trailing whitespace
  existingEmails: ["user@domain.com", "admin@site.com"], // List of existing emails
  alreadyExistsMessage: "This email already exists" // Message when email exists
);

if (emailError != null) {
  print("Email error: $emailError");
}
```

### 2. Phone Number Validation

```dart
// Phone number validation
String? phoneError = SahihValidator.phone(
  phone: "01234567890", // Phone number to validate
  emptyMessage: "Phone number is required", // Message when field is empty
  invalidFormatMessage: "Invalid phone number", // Message for invalid format
  trimWhitespace: true, // Remove leading/trailing whitespace
  existingPhones: ["01111111111", "01222222222"], // List of existing phone numbers
  alreadyExistsMessage: "This phone number is already registered" // Message when phone exists
);
```

### 3. Login Password Validation

```dart
// For login password validation (only checks if not empty)
String? loginPasswordError = SahihValidator.loginPassword(
  password: "mypassword123", // Password to validate
  emptyMessage: "Password is required", // Message when field is empty
);
```

### 4. Password Strength Validation

```dart
// For password strength validation when creating new account
String? passwordStrengthError = SahihValidator.passwordParts(
  "MyPassword123!", // Password to check strength
  commonPasswords: ["password", "123456", "qwerty"] // List of common passwords to reject
);
```

### 5. Custom Validation

```dart
// Comprehensive custom validation example
String? customError = SahihValidator.custom(
  value: "John Doe", // Value to validate
  title: "Name", // Field title to use in messages
  trimWhitespace: true, // Remove leading/trailing whitespace
  isRequired: true, // Whether the field is required
  minLength: 2, // Minimum character length
  maxLength: 50, // Maximum character length
  pattern: r'^[a-zA-Z\s]+$', // Custom regex pattern
  patternType: PatternType.name, // Pre-defined pattern type
  allowOnlyNumbers: false, // Allow only numbers
  allowOnlyLetters: true, // Allow only letters
  emptyMessage: "Name is required", // Empty field message
  minLengthMessage: "Name must be at least 2 characters", // Minimum length message
  maxLengthMessage: "Name is too long", // Maximum length exceeded message
  invalidPatternMessage: "Name contains invalid characters", // Invalid pattern message
  invalidNumberMessage: "Name cannot contain numbers", // Numbers not allowed message
  invalidLettersMessage: "Must contain only letters", // Letters only message
  customValidator: (value) { // Custom validation function
    if (value.split(' ').length < 2) {
      return "Please enter both first and last name";
    }
    return null;
  },
  existingValues: ["John Smith", "Jane Doe"], // List of existing values
  alreadyExistsMessage: "This name is already registered" // Value exists message
);
```

## Practical Form Example

```dart
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: "Email"),
            validator: (value) => SahihValidator.email(
              email: value ?? "",
              emptyMessage: "Email is required",
              invalidFormatMessage: "Invalid email format",
            ),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Phone Number"),
            validator: (value) => SahihValidator.phone(
              phone: value ?? "",
              emptyMessage: "Phone number is required",
            ),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
            validator: (value) => SahihValidator.passwordParts(
              value ?? "",
              commonPasswords: ["password", "123456"],
            ),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Full Name"),
            validator: (value) => SahihValidator.custom(
              value: value ?? "",
              title: "Name",
              isRequired: true,
              minLength: 2,
              allowOnlyLetters: true,
              customValidator: (val) {
                if (val.split(' ').length < 2) {
                  return "Enter both first and last name";
                }
                return null;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Data is valid
                print("Validation successful!");
              }
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}
```
## License

MIT License

## Support

For questions or support, please open an issue on GitHub.