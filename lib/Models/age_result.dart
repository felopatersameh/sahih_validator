/// Represents an exact age result in years, months, and days.
class AgeResult {
  /// The number of full years.
  final int years;

  /// The number of additional months after the years.
  final int months;

  /// The number of additional days after the months.
  final int days;

  /// Creates an [AgeResult] with the specified [years], [months], and [days].
  AgeResult({required this.years, required this.months, required this.days});
}
