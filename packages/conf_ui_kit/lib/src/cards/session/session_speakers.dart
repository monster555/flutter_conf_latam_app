import 'package:conf_shared_models/conf_shared_models.dart' show Session;
import 'package:conf_ui_kit/src/extensions/session_extensions.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

class SessionSpeakers extends StatelessWidget {
  const SessionSpeakers({required this.session, super.key});

  final Session session;

  Widget _buildSpeakerImage(BuildContext context) {
    final speakers = session.displaySpeakers;
    final firstSpeaker = speakers.first;
    final imageUrl = firstSpeaker.imageUrl;

    if (imageUrl.isEmpty) return _buildStandardFallback(context);

    return ClipOval(
      child: Semantics(
        label: 'Speaker: ${firstSpeaker.name}',
        image: true,
        child: Image.network(
          imageUrl,
          width: UiConstants.spacing24,
          height: UiConstants.spacing24,
          fit: BoxFit.cover,
          errorBuilder: _buildErrorFallback,
        ),
      ),
    );
  }

  Widget _buildErrorFallback(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) => _buildFallbackIcon(context);

  Widget _buildStandardFallback(BuildContext context) =>
      _buildFallbackIcon(context);

  Widget _buildFallbackIcon(BuildContext context) {
    return SizedBox.square(
      dimension: UiConstants.spacing24,
      child: Icon(
        Icons.person_outline,
        size: UiConstants.spacing16,
        color: context.colorScheme.onSurface.withValues(alpha: 0.7),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!session.shouldDisplaySpeakers) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(
        top: UiConstants.spacing4,
        bottom: UiConstants.spacing8,
      ),
      child: Row(
        children: [
          _buildSpeakerImage(context),

          const SizedBox(width: UiConstants.spacing4),
          Expanded(child: Text(session.speakersDisplayText)),
        ],
      ),
    );
  }
}
