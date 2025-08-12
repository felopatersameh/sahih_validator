/// Extensions for address validation checks.
extension AddressValidationExtensions on String {
  /// Checks if string contains numbers.
  bool get containsNumbers => RegExp(r'\d').hasMatch(this);

  /// Checks if string contains letters.
  bool get containsLetters => RegExp(r'[a-zA-Z]').hasMatch(this);

  /// Checks if string contains special characters.
  bool get containsSpecialChars =>
      RegExp(r'[!@#$%^&*()_+=\[\]{};:"\\|,.<>?]').hasMatch(this);

  /// Checks if address has street number.
  bool get hasStreetNumber =>
      RegExp(r'^\d+\s|#\d+|\d+[a-zA-Z]?\s').hasMatch(this);

  /// Checks if address has street name.
  bool get hasStreetName {
    const streetTypes = [
      'street',
      'st',
      'avenue',
      'ave',
      'road',
      'rd',
      'lane',
      'ln',
      'drive',
      'dr',
      'court',
      'ct',
      'place',
      'pl',
      'way',
      'blvd',
      'boulevard',
      'circle',
      'cir',
      'square',
      'sq',
    ];
    return streetTypes.any((type) => toLowerCase().contains(type));
  }

  /// Checks if address has city.
  bool get hasCity => RegExp(r'[a-zA-Z]{2,}').hasMatch(this);

  /// Checks if address has postal code.
  bool get hasPostalCode => RegExp(
    r'\d{5}(-\d{4})?|[A-Z]\d[A-Z]\s?\d[A-Z]\d|[A-Z]{1,2}\d[A-Z\d]?\s?\d[A-Z]{2}',
  ).hasMatch(this);

  /// Checks if address has country.
  bool get hasCountry {
    const commonCountries = [
      'usa',
      'canada',
      'uk',
      'united states',
      'united kingdom',
      'australia',
      'germany',
      'france',
      'italy',
      'spain',
      'egypt',
      'saudi arabia',
      'uae',
      'qatar',
      'kuwait',
    ];
    return commonCountries.any((c) => toLowerCase().contains(c));
  }

  /// Checks if address contains forbidden words.
  bool containsForbiddenWord(List<String>? words) {
    if (words == null || words.isEmpty) return false;
    return words.any((word) => toLowerCase().contains(word.toLowerCase()));
  }

  /// Checks if address contains required words.
  bool containsRequiredWords(List<String>? words) {
    if (words == null || words.isEmpty) return true;
    return words.every((word) => toLowerCase().contains(word.toLowerCase()));
  }

  /// Checks if address is duplicate.
  bool isDuplicate(List<String>? existing) {
    if (existing == null || existing.isEmpty) return false;
    return existing.any((e) => e.toLowerCase().trim() == toLowerCase());
  }
}
