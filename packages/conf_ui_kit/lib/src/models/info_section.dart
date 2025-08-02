import 'package:flutter/material.dart';

/// A model representing an information section with a title, description, and
/// icon.
///
/// Used with InfoCard and other components that display categorized
/// information.
class InfoSection {
  /// Creates an information section with title, description, and icon.
  const InfoSection({
    required this.title,
    required this.description,
    required this.icon,
  });

  /// The title of the information section.
  final String title;

  /// The descriptive text content.
  final String description;

  /// The icon representing this section.
  final IconData icon;
}
