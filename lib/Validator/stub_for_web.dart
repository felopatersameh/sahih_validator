/// Stub implementation for web platform compatibility.
/// This file provides empty implementations for dart:io functionality
/// that is not available on web platforms.
library;

/// Stub class for InternetAddress on web platforms.
class InternetAddress {
  /// Stub method for DNS lookup on web platforms.
  /// Always returns false since DNS lookup is not available on web.
  static Future<List<InternetAddress>> lookup(String host) async {
    throw UnsupportedError('DNS lookup is not supported on web platforms');
  }
}
