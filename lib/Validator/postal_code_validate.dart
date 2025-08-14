// import '../Models/country_enum.dart';

// /// Validates postal codes for different countries.
// ///
// /// If a country is specified, it uses that country's specific postal code
// /// pattern for validation. If a list of countries is provided, it validates
// /// against the patterns of those countries. If no country or list is
// /// provided, it attempts to validate against a predefined list of
// /// commonly used patterns.
// ///
// /// Returns `null` if the postal code is valid, otherwise returns an error message.
// String? validatePostalCode(
//   String postalCode, {
//   String title = "Postal Code",
//   bool isRequired = true,
//   List<CountryEnum>? allowedCountries,
// }) {
//   final value = postalCode.trim();

//   if (isRequired && value.isEmpty) {
//     return "$title is required";
//   }
//   if (!isRequired && value.isEmpty) {
//     return null;
//   }

//   // 2. If a list of allowed countries is provided, check against their patterns.
//   if (allowedCountries != null && allowedCountries.isNotEmpty) {
//     for (final c in allowedCountries) {
//       if (c.validatePostalCode(value)) {
//         return null;
//       }
//     }
//     return "$title format is invalid for the specified countries";
//   }

//   // 3. If neither a single country nor a list is specified,
//   //    check against our pre-filtered list of countries with patterns.
//   for (final c in countriesWithPostalCodeValidation) {
//     if (c.validatePostalCode(value)) {
//       return null;
//     }
//   }

//   return "$title format is invalid";
// }

// /// A pre-filtered list of countries with known postal code validation patterns.
// /// This is more efficient for the general case.
// final List<CountryEnum> countriesWithPostalCodeValidation =
//     CountryEnum.values.where((c) => c.postalCodePattern != "none").toList();
