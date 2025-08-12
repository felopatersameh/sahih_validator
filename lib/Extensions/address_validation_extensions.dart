extension AddressValidationExtensions on String {
  bool get containsNumbers => RegExp(r'\d').hasMatch(this);
  bool get containsLetters => RegExp(r'[a-zA-Z]').hasMatch(this);
  bool get containsSpecialChars =>
      RegExp(r'[!@#$%^&*()_+=\[\]{};:"\\|,.<>?]').hasMatch(this);

  bool get hasStreetNumber =>
      RegExp(r'^\d+\s|#\d+|\d+[a-zA-Z]?\s').hasMatch(this);
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

  bool get hasCity => RegExp(r'[a-zA-Z]{2,}').hasMatch(this);
  bool get hasPostalCode => RegExp(
    r'\d{5}(-\d{4})?|[A-Z]\d[A-Z]\s?\d[A-Z]\d|[A-Z]{1,2}\d[A-Z\d]?\s?\d[A-Z]{2}',
  ).hasMatch(this);
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

  bool containsForbiddenWord(List<String>? words) {
    if (words == null || words.isEmpty) return false;
    return words.any((word) => toLowerCase().contains(word.toLowerCase()));
  }

  bool containsRequiredWords(List<String>? words) {
    if (words == null || words.isEmpty) return true;
    return words.every((word) => toLowerCase().contains(word.toLowerCase()));
  }

  bool isDuplicate(List<String>? existing) {
    if (existing == null || existing.isEmpty) return false;
    return existing.any((e) => e.toLowerCase().trim() == toLowerCase());
  }
}
