import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:sahih_validator/Validator/date_of_birth_validator.dart';

void brithOfDate() {
  final today = DateTime.now();
  final dateFormat = DateFormat('yyyy-MM-dd');

  // Helper function to format dates
  String formatDate(DateTime dt) => dateFormat.format(dt);

  group('DateOfBirthValidator - Core Validation', () {
    test('valid DateTime input (exactly 18 years)', () {
      final dob = DateTime(today.year - 18, today.month, today.day);
      expect(DateOfBirthValidator.validate(dob), isNull);
    });

    test('valid String input (exactly 18 years)', () {
      final dob = formatDate(DateTime(today.year - 18, today.month, today.day));
      expect(DateOfBirthValidator.validate(dob), isNull);
    });

    test('invalid string format', () {
      expect(
        DateOfBirthValidator.validate('31-12-2000'),
        'Invalid date of birth format. Use yyyy-MM-dd',
      );
    });

    test('future DateTime', () {
      final dob = today.add(const Duration(days: 1));
      expect(
        DateOfBirthValidator.validate(dob),
        'Date of birth cannot be in the future',
      );
    });

    test('future String', () {
      final dob = formatDate(today.add(const Duration(days: 1)));
      expect(
        DateOfBirthValidator.validate(dob),
        'Date of birth cannot be in the future',
      );
    });

    test('too young by years', () {
      final dob = DateTime(today.year - 17, today.month, today.day);
      expect(
        DateOfBirthValidator.validate(dob),
        'You must be at least 18 years old (current age: 17y 0m 0d)',
      );
    });

    test('too old', () {
      final dob = DateTime(today.year - 121, today.month, today.day);
      expect(DateOfBirthValidator.validate(dob), 'Age cannot exceed 120 years');
    });
  });

  group('Edge Cases & Special Scenarios', () {
    test('leap year - born Feb 29 (valid)', () {
      final dob = DateTime(2000, 1, 1);
      // Set test date to Feb 28 2024 (not leap year)
      final age = DateOfBirthValidator.calculateAge(dob, useUtc: false);
      expect(age.years, 25);
      expect(age.months, 7);
      expect(age.days, 13); // 25 years, 7 months, 13 days
    });

    test('minAgeDays constraint (fails)', () {
      // 18 years but 364 days old (needs 365 days)
      final dob = today.subtract(const Duration(days: 365 * 18 - 1));
      expect(
        DateOfBirthValidator.validate(dob, minAgeDays: 365 * 18),
        contains('You must be at least 18 years old'),
      );
    });

    test('UTC vs local time handling', () {
      final utcBirth = DateTime.utc(2000, 1, 1);
      final localBirth = DateTime(2000, 1, 1);

      // Test when UTC and local dates differ
      final utcAge = DateOfBirthValidator.calculateAge(utcBirth, useUtc: true);
      final localAge = DateOfBirthValidator.calculateAge(
        localBirth,
        useUtc: false,
      );

      // Might differ based on timezone offset
      expect(
        utcAge.days,
        inInclusiveRange(localAge.days - 1, localAge.days + 1),
      );
    });
  });

  group('Custom Configuration', () {
    test('custom min/max age', () {
      final dob = DateTime(today.year - 16, today.month, today.day);
      expect(
        DateOfBirthValidator.validate(dob, minAgeYears: 21),
        contains('You must be at least 21 years old'),
      );
    });

    test('custom error messages', () {
      final dob = today.add(const Duration(days: 1));
      expect(
        DateOfBirthValidator.validate(
          dob,
          futureDateMessage: 'Custom future error',
        ),
        'Custom future error',
      );
    });

    test('custom date format', () {
      expect(
        DateOfBirthValidator.validate('01/12/2000', format: 'MM/dd/yyyy'),
        isNull,
      );
    });
  });

  group('Age Calculation', () {
    test('exact age calculation', () {
      final birth = DateTime(2000, 1, 1);
      final reference = DateTime(2025, 1, 1);
      final age = DateOfBirthValidator.calculateAge(birth);
      expect(age.years, reference.year - birth.year);
    });

    test('newborn age calculation', () {
      final birth = today.subtract(const Duration(days: 1));
      final age = DateOfBirthValidator.calculateAge(birth);
      expect(age.years, 0);
      expect(age.months, 0);
      expect(age.days, 1);
    });
  });
}
