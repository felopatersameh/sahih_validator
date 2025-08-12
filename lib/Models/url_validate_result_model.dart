class UrlValidationResult {
  final bool isValid;
  final String message;
  final UrlData? data;

  const UrlValidationResult({
    required this.isValid,
    required this.message,
    this.data,
  });
}

class UrlData {
  final String protocol; // https أو http
  final String host; // www.google.com
  final String domain; // google.com
  final int? port; // 80, 443, 3000, etc
  final String path; // /search/results
  final String? query; // ?q=flutter&lang=en
  final String? fragment; // #section1
  final String fullUrl; // full normalized URL

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
}
