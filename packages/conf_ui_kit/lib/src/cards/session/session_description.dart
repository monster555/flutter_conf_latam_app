import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

class SessionDescription extends StatelessWidget {
  const SessionDescription({required this.description, super.key});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: context.textTheme.bodySmall,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
