library;

/// Stub class for InternetAddress on web platforms.
/// This class mimics the interface of dart:io's InternetAddress
/// to ensure compatibility on platforms that do not support DNS operations.
class InternetAddress {
  /// Default constructor for the stubbed InternetAddress class.
  /// Used for compatibility only.
  const InternetAddress();

  /// Stub method for DNS lookup on web platforms.
  ///
  /// Always throws an [UnsupportedError] because DNS lookups
  /// are not available in Flutter Web.
  static Future<List<InternetAddress>> lookup(String host) async {
    throw UnsupportedError('DNS lookup is not supported on web platforms');
  }

  /// Stub getter that mimics the `address` property of dart:io's InternetAddress.
  ///
  /// Always returns an empty string since IP addresses cannot be resolved on web.
  String get address => '';
}
