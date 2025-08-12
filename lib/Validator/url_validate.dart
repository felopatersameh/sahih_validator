import 'dart:io';
import '../Models/url_validate_result_model.dart';

Future<T> isValidUrlAsync<T>(
  String url, {
  bool allowRelative = false,
  List<String>? allowedSchemes,
  List<String>? allowedDomains,
  bool normalize = true,
  bool checkDomainExists = true,
}) async {
  UrlValidationResult result;

  if (url.trim().isEmpty) {
    result = UrlValidationResult(isValid: false, message: "URL is required");
    return _castResult<T>(result);
  }

  String trimmedUrl = url.trim();

  try {
    Uri uri = Uri.parse(trimmedUrl);

    // Allow relative paths
    if (allowRelative && !uri.hasScheme && uri.path.isNotEmpty) {
      result = UrlValidationResult(isValid: true, message: "Relative URL is valid");
      return _castResult<T>(result);
    }

    // Scheme check
    if (uri.scheme.isEmpty) {
      result = UrlValidationResult(isValid: false, message: "URL must start with http:// or https://");
      return _castResult<T>(result);
    }

    if (allowedSchemes != null && !allowedSchemes.contains(uri.scheme.toLowerCase())) {
      result = UrlValidationResult(isValid: false, message: "Scheme '${uri.scheme}' is not allowed");
      return _castResult<T>(result);
    }

    if (!uri.hasAuthority || uri.host.isEmpty) {
      result = UrlValidationResult(isValid: false, message: "URL must have a valid domain");
      return _castResult<T>(result);
    }

    // Domain whitelist check
    if (allowedDomains != null && !allowedDomains.contains(uri.host.toLowerCase())) {
      result = UrlValidationResult(isValid: false, message: "Domain '${uri.host}' is not allowed");
      return _castResult<T>(result);
    }

    // Optional DNS check
    if (checkDomainExists) {
      try {
        final lookup = await InternetAddress.lookup(uri.host);
        if (lookup.isEmpty || lookup.first.rawAddress.isEmpty) {
          result = UrlValidationResult(isValid: false, message: "Domain does not exist");
          return _castResult<T>(result);
        }
      } catch (_) {
        result = UrlValidationResult(isValid: false, message: "Domain lookup failed");
        return _castResult<T>(result);
      }
    }

    UrlData urlData = UrlData(
      protocol: uri.scheme.toLowerCase(),
      host: uri.host.toLowerCase(),
      domain: _extractDomain(uri.host),
      port: uri.hasPort ? uri.port : null,
      path: uri.path.isEmpty ? "/" : uri.path,
      query: uri.query.isEmpty ? null : uri.query,
      fragment: uri.fragment.isEmpty ? null : uri.fragment,
      fullUrl: normalize ? _normalizeUrl(uri) : trimmedUrl,
    );

    result = UrlValidationResult(isValid: true, message: "URL is valid", data: urlData);
    return _castResult<T>(result);

  } catch (e) {
    result = UrlValidationResult(isValid: false, message: "URL format is invalid");
    return _castResult<T>(result);
  }
}

T _castResult<T>(UrlValidationResult result) {
  if (T == String) {
    return result.message as T;
  }
  else if (T == bool) {
    return result.isValid as T;
  }


  return result as T;
}

String _extractDomain(String host) {
  List<String> parts = host.split('.');
  if (parts.length >= 2) {
    return '${parts[parts.length - 2]}.${parts[parts.length - 1]}';
  }
  return host;
}

String _normalizeUrl(Uri uri) {
  String url = uri.toString();
  if (url.endsWith('/')) url = url.substring(0, url.length - 1);
  return url;
}
