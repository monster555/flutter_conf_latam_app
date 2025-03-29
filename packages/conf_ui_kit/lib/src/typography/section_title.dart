import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

/// A consistently styled section title.
class SectionTitle extends StatelessWidget {
  /// Creates a consistently styled section title.
  const SectionTitle({
    required this.title,
    this.padding = const EdgeInsets.only(bottom: UiConstants.spacing16),
    super.key,
  });

  /// The title text to display.
  final String title;

  /// Optional padding around the title.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = context.textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
    );

    return Padding(
      padding: padding,
      child: Semantics(
        header: true,
        child: Text(title, style: defaultStyle, softWrap: true),
      ),
    );
  }
}
