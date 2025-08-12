import 'package:flutter/material.dart';
import 'package:sahih_validator/sahih_validator.dart';

/// SahihValidator Example App
///
/// This example demonstrates all the validation capabilities of the SahihValidator
/// package including email, phone, password, address, URL, and custom validation.
///
/// The app shows practical usage patterns and best practices for integrating
/// the validator with Flutter forms and TextFormField widgets.
void main() {
  runApp(const SahihValidatorExampleApp());
}

/// Main application widget demonstrating SahihValidator usage
class SahihValidatorExampleApp extends StatelessWidget {
  const SahihValidatorExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SahihValidator Example',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ValidationExampleScreen(),
    );
  }
}

/// Main screen demonstrating various validation scenarios
class ValidationExampleScreen extends StatefulWidget {
  const ValidationExampleScreen({super.key});

  @override
  State<ValidationExampleScreen> createState() =>
      _ValidationExampleScreenState();
}

class _ValidationExampleScreenState extends State<ValidationExampleScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for different input types
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _addressController = TextEditingController();
  final _urlController = TextEditingController();
  final _usernameController = TextEditingController();
  final _productCodeController = TextEditingController();

  // URL validation results for demonstration
  String? _urlValidationMessage;
  bool? _urlIsValid;
  UrlValidationResult? _urlFullResult;

  // Sample data for duplicate checking
  final List<String> _existingEmails = [
    'admin@example.com',
    'user@test.com',
    'demo@site.org',
  ];

  final List<String> _existingUsernames = ['admin', 'root', 'test', 'demo'];

  /// Validates all form fields and demonstrates URL validation results
  void _validateAll() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Demonstrate different URL validation return types
      _urlValidationMessage = await SahihValidator.urlAsync<String>(
        _urlController.text,
      );
      _urlIsValid = await SahihValidator.urlAsync<bool>(_urlController.text);
      _urlFullResult = await SahihValidator.urlAsync(_urlController.text);

      setState(() {});

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All validations passed! ✅'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SahihValidator Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              const Text(
                'SahihValidator Demo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'This example demonstrates all validation features. Try entering invalid data to see the validation messages.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // Email validation section
              _buildSectionHeader('Email Validation'),
              _buildValidationField(
                label: 'Email Address',
                controller: _emailController,
                hint:
                    'Enter your email (try: admin@example.com to see duplicate error)',
                validator: (value) => SahihValidator.email(
                  email: value ?? '',
                  existingEmails: _existingEmails,
                  alreadyExistsMessage:
                      'This email is already registered. Try a different one.',
                ),
              ),

              // Phone validation section
              _buildSectionHeader('Phone Validation'),
              _buildValidationField(
                label: 'Phone Number',
                controller: _phoneController,
                hint: 'Enter 10-15 digits (e.g., +1234567890)',
                validator: (value) => SahihValidator.phone(
                  phone: value ?? '',
                  invalidFormatMessage:
                      'Please enter a valid phone number (10-15 digits)',
                ),
              ),

              // Password validation sections
              _buildSectionHeader('Password Validation'),
              _buildValidationField(
                label: 'Login Password',
                controller: _loginPasswordController,
                hint: 'For login - just checks if not empty',
                obscureText: true,
                validator: (value) => SahihValidator.loginPassword(
                  password: value ?? '',
                  emptyMessage: 'Password is required for login',
                ),
              ),

              _buildValidationField(
                label: 'New Password (Strength Check)',
                controller: _newPasswordController,
                hint: 'Must be strong - try: MySecureP@ssw0rd!',
                obscureText: true,
                validator: (value) => SahihValidator.passwordParts(value ?? ''),
              ),

              // Custom validation sections
              _buildSectionHeader('Custom Validation'),
              _buildValidationField(
                label: 'Username',
                controller: _usernameController,
                hint:
                    'Alphanumeric, 3-20 chars (try: admin to see duplicate error)',
                validator: (value) => SahihValidator.custom(
                  value: value ?? '',
                  title: 'Username',
                  minLength: 3,
                  maxLength: 20,
                  pattern: r'^[a-zA-Z0-9_]+$',
                  invalidPatternMessage:
                      'Username can only contain letters, numbers, and underscores',
                  existingValues: _existingUsernames,
                  alreadyExistsMessage:
                      'Username already taken. Please choose another.',
                ),
              ),

              _buildValidationField(
                label: 'Product Code',
                controller: _productCodeController,
                hint: 'Format: PRD-XXXX (e.g., PRD-1234)',
                validator: (value) => SahihValidator.custom(
                  value: value ?? '',
                  title: 'Product Code',
                  pattern: r'^PRD-\d{4}$',
                  invalidPatternMessage:
                      'Product code must be in format PRD-XXXX (e.g., PRD-1234)',
                ),
              ),

              // Address validation section
              _buildSectionHeader('Address Validation'),
              _buildValidationField(
                label: 'Full Address',
                controller: _addressController,
                hint: 'Include street number, name, and country',
                maxLines: 3,
                validator: (value) => SahihValidator.address(
                  address: value ?? '',
                  requireStreetNumber: true,
                  requireStreetName: true,
                  requireCountry: true,
                  minLength: 15,
                  missingStreetNumberMessage:
                      'Address must include a street number',
                  missingStreetNameMessage:
                      'Address must include a street name',
                  missingCountryMessage: 'Address must include a country',
                ),
              ),

              // URL validation section
              _buildSectionHeader('URL Validation'),
              _buildValidationField(
                label: 'Website URL',
                controller: _urlController,
                hint: 'Enter a complete URL (e.g., https://example.com)',
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'URL is required';
                  // Simple validation for form - detailed validation happens in _validateAll
                  return Uri.tryParse(value!)?.hasScheme == true
                      ? null
                      : 'Enter a valid URL';
                },
              ),

              const SizedBox(height: 32),

              // Validation button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _validateAll,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Validate All Fields',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              // URL validation results
              if (_urlValidationMessage != null ||
                  _urlIsValid != null ||
                  _urlFullResult != null) ...[
                const SizedBox(height: 24),
                _buildSectionHeader('URL Validation Results'),
                if (_urlValidationMessage != null)
                  _buildResultCard('Message Result', _urlValidationMessage!),
                if (_urlIsValid != null)
                  _buildResultCard('Boolean Result', _urlIsValid.toString()),
                if (_urlFullResult != null && _urlFullResult!.isValid)
                  _buildResultCard(
                    'Parsed URL Data',
                    'Domain: ${_urlFullResult!.data?.domain}\n'
                        'Protocol: ${_urlFullResult!.data?.protocol}\n'
                        'Path: ${_urlFullResult!.data?.path}\n'
                        'Full URL: ${_urlFullResult!.data?.fullUrl}',
                  ),
              ],

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a section header with consistent styling
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.blue,
        ),
      ),
    );
  }

  /// Builds a validation field with consistent styling and helpful hints
  Widget _buildValidationField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    String? hint,
    bool obscureText = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        maxLines: obscureText ? 1 : maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  /// Builds a result card to display validation results
  Widget _buildResultCard(String title, String content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 4),
            Text(content, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up controllers
    _emailController.dispose();
    _phoneController.dispose();
    _loginPasswordController.dispose();
    _newPasswordController.dispose();
    _addressController.dispose();
    _urlController.dispose();
    _usernameController.dispose();
    _productCodeController.dispose();
    super.dispose();
  }
}
