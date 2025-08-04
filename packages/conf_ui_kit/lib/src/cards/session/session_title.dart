import 'package:conf_shared_models/conf_shared_models.dart' show Session;
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

class SessionTitle extends StatelessWidget {
  const SessionTitle({required this.session, super.key});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return Text(
      session.title,
      style: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
