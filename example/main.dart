import 'package:flutter/material.dart';
import 'package:sahih_validator/sahih_validator.dart';

void main() {
  runApp(const ValidateScreenExample());
}

class ValidateScreenExample extends StatefulWidget {
  const ValidateScreenExample({super.key});

  @override
  State<ValidateScreenExample> createState() => _ValidateScreenExampleState();
}

class _ValidateScreenExampleState extends State<ValidateScreenExample> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _createPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _urlController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _urlResult;
  bool? _urlBoolResult;
  UrlValidationResult? _urlFullResult;

  void _validateAll() async {
    if (_formKey.currentState?.validate() ?? false) {
      _urlResult = await SahihValidator.urlAsync<String>(_urlController.text);
      _urlBoolResult = await SahihValidator.urlAsync<bool>(_urlController.text);
      _urlFullResult = await SahihValidator.urlAsync(_urlController.text);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Validation Example")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildField(
                  label: "Email",
                  controller: _emailController,
                  validator: (value) =>
                      SahihValidator.email(email: value ?? ""),
                ),
                _buildField(
                  label: "Create Password",
                  controller: _createPasswordController,
                  validator: (value) =>
                      SahihValidator.passwordParts(value ?? ""),
                ),
                _buildField(
                  label: "Password",
                  controller: _passwordController,
                  validator: (value) =>
                      SahihValidator.loginPassword(password: value ?? ""),
                ),
                _buildField(
                  label: "Phone",
                  controller: _phoneController,
                  validator: (value) =>
                      SahihValidator.phone(phone: value ?? ""),
                ),
                _buildField(
                  label: "Address",
                  controller: _addressController,
                  validator: (value) => SahihValidator.address(
                    address: value ?? "",
                    requireStreetNumber: true,
                    requireStreetName: true,
                    requireCountry: true,
                  ),
                ),
                _buildField(
                  label: "URL",
                  controller: _urlController,
                  validator: (value) {
                    final msg =
                        Uri.tryParse(value ?? "")?.hasAbsolutePath == true
                        ? null
                        : "Enter a valid URL";
                    return msg;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _validateAll,
                  child: const Text("Validate All"),
                ),
                const SizedBox(height: 20),
                if (_urlResult != null) Text("URL message: $_urlResult"),
                if (_urlBoolResult != null)
                  Text("URL is valid? $_urlBoolResult"),
                if (_urlFullResult != null)
                  Text("Full URL result: ${_urlFullResult!.data?.fullUrl}"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }
}
