import 'package:url_launcher/url_launcher.dart' as url_launcher;

/// Utility for launching external links and applications.
class ExternalLinkUtil {
  /// Launches a URL in the default browser.
  static Future<bool> launchUrl(String url) async {
    final uri = Uri.parse(url);
    return url_launcher.launchUrl(
      uri,
      mode: url_launcher.LaunchMode.externalApplication,
    );
  }

  /// Checks if a URL can be launched.
  static Future<bool> canLaunchUrl(String url) async {
    final uri = Uri.parse(url);
    return url_launcher.canLaunchUrl(uri);
  }

  /// Opens a map application with the specified coordinates.
  static Future<bool> openMap(double latitude, double longitude) async {
    final mapUrl = _buildMapUrl(latitude, longitude);
    return launchUrl(mapUrl);
  }

  /// Builds a Google Maps URL with the given coordinates.
  static String _buildMapUrl(double latitude, double longitude) =>
      'https://maps.google.com/?q=$latitude,$longitude';
}
