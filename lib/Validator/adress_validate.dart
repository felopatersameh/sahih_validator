import '../Extensions/address_validation_extensions.dart';

String? validateAddress({
  required String address,
  String? title = "Address",
  bool trimWhitespace = true,
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
  List<String>? existingAddresses,
  String? emptyMessage,
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
  String? alreadyExistsMessage,
}) {
  String value = trimWhitespace ? address.trim() : address;

  if (isRequired && value.isEmpty) {
    return emptyMessage ?? "$title is required";
  }
  if (!isRequired && value.isEmpty) return null;

  if (value.length < minLength) {
    return minLengthMessage ??
        "$title must be at least $minLength characters long";
  }
  if (value.length > maxLength) {
    return maxLengthMessage ?? "$title cannot exceed $maxLength characters";
  }

  if (!allowNumbers && value.containsNumbers) {
    return invalidNumbersMessage ?? "$title cannot contain numbers";
  }
  if (!allowLetters && value.containsLetters) {
    return invalidLettersMessage ?? "$title must contain letters";
  }
  if (!allowSpecialChars && value.containsSpecialChars) {
    return invalidSpecialCharsMessage ??
        "$title cannot contain special characters";
  }

  if (requireStreetNumber && !value.hasStreetNumber) {
    return missingStreetNumberMessage ?? "$title must include a street number";
  }
  if (requireStreetName && !value.hasStreetName) {
    return missingStreetNameMessage ?? "$title must include a street name";
  }
  if (requireCity && !value.hasCity) {
    return missingCityMessage ?? "$title must include a city name";
  }

  if (requireCountry && !value.hasCountry) {
    return missingCountryMessage ?? "$title must include a country";
  }

  if (value.containsForbiddenWord(forbiddenWords)) {
    return forbiddenWordsMessage ?? "$title contains forbidden words";
  }
  if (!value.containsRequiredWords(requiredWords)) {
    return requiredWordsMessage ?? "$title must contain required words";
  }

  if (value.isDuplicate(existingAddresses)) {
    return alreadyExistsMessage ?? "This $title already exists";
  }

  return null;
}
