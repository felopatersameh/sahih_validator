import 'package:intl/intl.dart';
import 'package:sahih_validator/Models/age_result.dart';

/// A utility class for validating a date of birth and calculating exact age.
class DateOfBirthValidator {
  /// Validates a date of birth string or DateTime and returns an error message if invalid.
  ///
  /// [dob] can be either a `String` in the given [format] or a `DateTime` object.
  /// [format] is only used if [dob] is a String (default: "yyyy-MM-dd").
  /// [minAgeYears] is the minimum allowed age (default: 18 years).
  /// [maxAgeYears] is the maximum allowed age (default: 120 years).
  /// [minAgeDays] can be set if you want to enforce a specific minimum age in days.
  /// [useUtc] decides whether to calculate using UTC time (default: false).
  /// Custom error messages can be provided for each validation rule.
  static String? validate(
    dynamic dob, {
    String format = "yyyy-MM-dd",
    int minAgeYears = 18,
    int maxAgeYears = 120,
    int? minAgeDays,
    bool useUtc = false,

    // Custom error messages
    String? invalidFormatMessage,
    String? futureDateMessage,
    String? tooYoungMessage,
    String? tooOldMessage,
  }) {
    try {
      DateTime birthDate;

      if (dob is String) {
        DateFormat formatter = DateFormat(format);
        birthDate = formatter.parseStrict(dob);
      } else if (dob is DateTime) {
        birthDate = dob;
      } else {
        return invalidFormatMessage ?? "Invalid date of birth format";
      }

      DateTime today = useUtc ? DateTime.now().toUtc() : DateTime.now();

      if (birthDate.isAfter(today)) {
        return futureDateMessage ?? "Date of birth cannot be in the future";
      }

      AgeResult age = _calculateExactAge(birthDate, today);

      if (age.years < minAgeYears ||
          (minAgeDays != null && _ageInDays(age) < minAgeDays)) {
        return tooYoungMessage ??
            "You must be at least $minAgeYears years old (current age: ${age.years}y ${age.months}m ${age.days}d)";
      }

      if (age.years > maxAgeYears) {
        return tooOldMessage ?? "Age cannot exceed $maxAgeYears years";
      }

      return null; // Valid
    } catch (_) {
      return invalidFormatMessage ??
          "Invalid date of birth format. Use $format";
    }
  }

  /// Calculates the exact age from a date of birth.
  static AgeResult calculateAge(DateTime birthDate, {bool useUtc = false}) {
    DateTime today = useUtc ? DateTime.now().toUtc() : DateTime.now();
    return _calculateExactAge(birthDate, today);
  }

  /// Internal method to calculate exact years, months, and days.
  static AgeResult _calculateExactAge(DateTime birthDate, DateTime today) {
    int years = today.year - birthDate.year;
    int months = today.month - birthDate.month;
    int days = today.day - birthDate.day;

    if (days < 0) {
      months--;
      days += DateTime(today.year, today.month, 0).day;
    }
    if (months < 0) {
      years--;
      months += 12;
    }

    return AgeResult(years: years, months: months, days: days);
  }

  /// Converts an AgeResult to total days.
  static int _ageInDays(AgeResult age) {
    return age.years * 365 + age.months * 30 + age.days;
  }
}
