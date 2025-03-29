import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Central service for consistent date formatting throughout the app.
class DateFormatService {
  DateFormatService._();

  /// Format a date for display in schedule tabs (e.g., "Mon 9")
  static String formatTabDate(DateTime date, BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return DateFormat('dd MMM', locale).format(date);
  }

  /// Format a date with date and time (e.g., "Sep 9, 2025 at 10:30 AM")
  static String formatDateAndTime(DateTime date, BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return DateFormat.yMMMd(locale).add_jm().format(date);
  }

  /// Format a full date (e.g., "September 9, 2025")
  static String formatFullDate(DateTime date, BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return DateFormat.yMMMMd(locale).format(date);
  }

  /// Format just the date (e.g., "Sep 9, 2025")
  static String formatDate(DateTime date, BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return DateFormat.yMMMd(locale).format(date);
  }

  /// Format just the time (e.g., "10:30 AM")
  static String formatTime(DateTime time, BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return DateFormat.jm(locale).format(time);
  }

  /// Format time in 24-hour format (e.g., "10:30")
  static String formatTime24Hours(DateTime time, BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return DateFormat.Hm(locale).format(time);
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

  /// Format a range between two dates (e.g., "9-10 Sept")
  static String formatDateRange(
    DateTime start,
    DateTime end,
    BuildContext context,
  ) {
    final locale = Localizations.localeOf(context).languageCode;

    if (start.month == end.month && start.year == end.year) {
      // Same month, just show range of days
      return '${start.day}-${end.day} ${DateFormat.MMM(locale).format(start)}';
    } else {
      // Different months
      return '${start.day} ${DateFormat.MMM(locale).format(start)} - '
          '${end.day} ${DateFormat.MMM(locale).format(end)}';
    }
  }
}
