import 'dart:async';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

/// Displays an animated countdown to the conference date
class CountdownWidget extends StatefulWidget {
  /// Creates a countdown widget that shows days, hours, minutes, and seconds
  /// until the specified target date
  const CountdownWidget({
    required this.targetDate,
    required this.daysLabel,
    required this.hoursLabel,
    required this.minutesLabel,
    required this.secondsLabel,
    this.title,
    this.eventStartedMessage,
    super.key,
  });

  /// The target date to count down to
  final DateTime targetDate;

  /// Optional title to display above the countdown
  final String? title;

  /// The label to display for the days unit
  final String daysLabel;

  /// The label to display for the hours unit
  final String hoursLabel;

  /// The label to display for the minutes unit
  final String minutesLabel;

  /// The label to display for the seconds unit
  final String secondsLabel;

  /// Message to display when the event has started (optional)
  final String? eventStartedMessage;

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late Timer _timer;
  int _days = 0;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  bool _isEventPassed = false;

  @override
  void initState() {
    super.initState();
    _calculateTimeLeft();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateTimeLeft();
    });
  }

  void _calculateTimeLeft() {
    final now = DateTime.now();
    final difference = widget.targetDate.difference(now);

    if (difference.isNegative) {
      _timer.cancel();
      setState(() {
        _days = 0;
        _hours = 0;
        _minutes = 0;
        _seconds = 0;
        _isEventPassed = true;
      });
      return;
    }

    setState(() {
      _days = difference.inDays;
      _hours = difference.inHours.remainder(24);
      _minutes = difference.inMinutes.remainder(60);
      _seconds = difference.inSeconds.remainder(60);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CountdownCard(
          title: widget.title,
          days: _days,
          hours: _hours,
          minutes: _minutes,
          seconds: _seconds,
          isEventPassed: _isEventPassed,
          daysLabel: widget.daysLabel,
          hoursLabel: widget.hoursLabel,
          minutesLabel: widget.minutesLabel,
          secondsLabel: widget.secondsLabel,
          eventStartedMessage: widget.eventStartedMessage,
        ),
      ],
    );
  }
}

class _CountdownCard extends StatelessWidget {
  const _CountdownCard({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.daysLabel,
    required this.hoursLabel,
    required this.minutesLabel,
    required this.secondsLabel,

    this.title,
    this.eventStartedMessage,
    this.isEventPassed = false,
  });

  final String? title;
  final int days;
  final int hours;
  final int minutes;
  final int seconds;
  final bool isEventPassed;
  final String daysLabel;
  final String hoursLabel;
  final String minutesLabel;
  final String secondsLabel;
  final String? eventStartedMessage;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    final child =
        isEventPassed
            ? _buildEventPassedMessage(textTheme, colorScheme)
            : _buildCountdown(textTheme);

    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(color: colorScheme.secondary),
        child: Padding(
          padding: const EdgeInsets.all(UiConstants.spacing16),
          child: child,
        ),
      ),
    );
  }

  Widget _buildEventPassedMessage(
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Semantics(
      label: eventStartedMessage ?? '¡El evento ha comenzado!',
      container: true,
      child: Center(
        child: Text(
          eventStartedMessage ?? '¡El evento ha comenzado!',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCountdown(TextTheme textTheme) {
    const effectiveColor = Colors.white;
    return Semantics(
      label:
          '${title ?? ''} $days $daysLabel, $hours $hoursLabel, $minutes '
          '$minutesLabel, $seconds $secondsLabel',
      liveRegion: true,
      container: true,
      hint: 'Countdown to event',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: textTheme.titleMedium?.copyWith(color: effectiveColor),
            ),
            const SizedBox(height: UiConstants.spacing8),
          ],

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _CountdownUnit(
                value: days,
                label: daysLabel,
                color: effectiveColor,
                wholeDigits: days > 99 ? 3 : 2,
              ),
              const _CountdownSeparator(color: effectiveColor),
              _CountdownUnit(
                value: hours,
                label: hoursLabel,
                color: effectiveColor,
              ),
              const _CountdownSeparator(color: effectiveColor),
              _CountdownUnit(
                value: minutes,
                label: minutesLabel,
                color: effectiveColor,
              ),
              const _CountdownSeparator(color: effectiveColor),
              _CountdownUnit(
                value: seconds,
                label: secondsLabel,
                color: effectiveColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CountdownUnit extends StatelessWidget {
  const _CountdownUnit({
    required this.value,
    required this.label,
    required this.color,
    this.wholeDigits = 2,
  });
  final int value;
  final String label;
  final int wholeDigits;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Semantics(
      value: '$value $label',
      child: Column(
        children: [
          AnimatedFlipCounter(
            value: value,
            wholeDigits: wholeDigits,
            duration: UiConstants.animationXLong,
            curve: Curves.easeOutQuad,
            padding: const EdgeInsets.symmetric(
              horizontal: UiConstants.spacing4,
            ),
            textStyle: TextStyle(
              fontSize: UiConstants.fontSizeDisplay,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: UiConstants.spacing4),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: color.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountdownSeparator extends StatelessWidget {
  const _CountdownSeparator({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: SizedBox(
        width: UiConstants.borderWidth,
        height: UiConstants.dividerheight,
        child: DecoratedBox(
          decoration: BoxDecoration(color: color.withValues(alpha: 0.5)),
        ),
      ),
    );
  }
}
