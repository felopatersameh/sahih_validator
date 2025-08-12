enum PatternType { email, phone, number, strongPassword }

extension PatternTypeExtension on PatternType {
  bool isValid(String input) {
    switch (this) {
      case PatternType.email:
        return RegExp(
          r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$',
        ).hasMatch(input);
      case PatternType.phone:
        return RegExp(r'^\+?[0-9]{10,15}$').hasMatch(input);
      case PatternType.number:
        return RegExp(r'^\d+$').hasMatch(input);
      case PatternType.strongPassword:
        return _validateStrongPassword(input);
    }
  }

  bool _validateStrongPassword(String input) {
    return input.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(input) &&
        RegExp(r'[a-z]').hasMatch(input) &&
        RegExp(r'[0-9]').hasMatch(input) &&
        !RegExp(r'^[0-9]+$').hasMatch(input);
  }
}
