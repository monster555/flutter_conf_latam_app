import 'package:conf_ui_kit/src/extensions/locale_extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Central service for consistent date formatting throughout the app.
class DateFormatService {
  DateFormatService._();

  /// Global cache for formatters to avoid recreation
  static final Map<String, Map<String, DateFormat>> _formatters = {};

  /// Creates a formatter using the current locale from context
  static DateFormatter withContext(BuildContext context) =>
      DateFormatter(context.localeLanguageCode);

  /// Gets a cached formatter or creates a new one
  static DateFormat _getCachedFormatter(String pattern, String locale) {
    final localeFormatters = _formatters[locale] ??= {};
    return localeFormatters[pattern] ??= DateFormat(pattern, locale);
  }
}

/// Formatter that applies consistent date formatting with a specific locale
class DateFormatter {
  /// Create formatter with the specified locale
  const DateFormatter(this.locale);

  final String locale;

  /// Format a date for display in schedule tabs (e.g., "Mon 9")
  String formatTabDate(DateTime date) =>
      DateFormatService._getCachedFormatter('dd MMM', locale).format(date);

  /// Format a date with date and time (e.g., "Sep 9, 2025 at 10:30 AM")
  String formatDateAndTime(DateTime date) {
    final dateFormatter = DateFormatService._getCachedFormatter(
      'yMMMd',
      locale,
    );
    final timeFormatter = DateFormatService._getCachedFormatter(
      'hh:mm a',
      locale,
    );
    return '${dateFormatter.format(date)}, ${timeFormatter.format(date)}';
  }

  /// Format a full date (e.g., "September 9, 2025")
  String formatFullDate(DateTime date) =>
      DateFormatService._getCachedFormatter('yMMMMd', locale).format(date);

  /// Format just the date (e.g., "Sep 9, 2025")
  String formatDate(DateTime date) =>
      DateFormatService._getCachedFormatter('yMMMd', locale).format(date);

  /// Format just the time (e.g., "10:30 AM")
  String formatTime(DateTime time) =>
      DateFormatService._getCachedFormatter('jm', locale).format(time);

  /// Format time in 24-hour format (e.g., "10:30")
  String formatTime24Hours(DateTime time) =>
      DateFormatService._getCachedFormatter('Hm', locale).format(time);

  /// Format a range between two dates (e.g., "9-10 Sept")
  String formatDateRange(DateTime start, DateTime end) {
    final formatter = DateFormatService._getCachedFormatter('MMM', locale);

    if (start.month == end.month && start.year == end.year) {
      // Same month, just show range of days
      return '${start.day}-${end.day} ${formatter.format(start)}';
    } else {
      // Different months
      return '${start.day} ${formatter.format(start)} - '
          '${end.day} ${formatter.format(end)}';
    }
  }

  /// Format duration in hours and minutes
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0) {
      return minutes > 0 ? '${hours}h ${minutes}m' : '${hours}h';
    } else {
      return '${minutes}m';
    }
  }
}
