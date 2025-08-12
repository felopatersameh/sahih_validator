/// Result of URL validation containing validity status, message, and parsed data.
class UrlValidationResult {
  /// Whether the URL is valid.
  final bool isValid;

  /// Validation message.
  final String message;

  /// Parsed URL data if valid.
  final UrlData? data;

  /// Creates a URL validation result.
  const UrlValidationResult({
    required this.isValid,
    required this.message,
    this.data,
  });

  /// Converts to JSON map.
  Map<String, dynamic> toJson() {
    return {'isValid': isValid, 'message': message, 'data': data?.toJson()};
  }
}

/// Parsed URL data containing protocol, host, domain, path, etc.
class UrlData {
  /// URL protocol (https, http).
  final String protocol;

  /// Full host (www.google.com).
  final String host;

  /// Domain only (google.com).
  final String domain;

  /// Port number if specified.
  final int? port;

  /// URL path (/search/results).
  final String path;

  /// Query string (?q=flutter&lang=en).
  final String? query;

  /// Fragment (#section1).
  final String? fragment;

  /// Full normalized URL.
  final String fullUrl;

  /// Creates URL data.
  const UrlData({
    required this.protocol,
    required this.host,
    required this.domain,
    this.port,
    required this.path,
    this.query,
    this.fragment,
    required this.fullUrl,
  });

  @override
  String toString() {
    return 'UrlData(protocol: $protocol, host: $host, domain: $domain, port: $port, path: $path, query: $query, fragment: $fragment)';
  }

  /// Converts to JSON map.
  Map<String, dynamic> toJson() {
    return {
      'protocol': protocol,
      'host': host,
      'domain': domain,
      'port': port,
      'path': path,
      'query': query,
      'fragment': fragment,
      'fullUrl': fullUrl,
    };
  }
}
