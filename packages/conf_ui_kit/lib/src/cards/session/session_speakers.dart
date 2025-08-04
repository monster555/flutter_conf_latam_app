import 'package:conf_shared_models/conf_shared_models.dart' show SessionSpeaker;
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

class SessionSpeakers extends StatelessWidget {
  const SessionSpeakers({required this.speakers, super.key});

  final List<SessionSpeaker> speakers;

  Widget _buildSpeakerImage(ColorScheme colorScheme) {
    final firstSpeaker = speakers.first;
    final imageUrl = firstSpeaker.imageUrl;

    if (imageUrl.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          imageUrl,
          width: UiConstants.spacing24,
          height: UiConstants.spacing24,
          fit: BoxFit.cover,
          errorBuilder:
              (context, error, stackTrace) => _buildFallbackIcon(colorScheme),
        ),
      );
    }
    return _buildFallbackIcon(colorScheme);
  }

  Widget _buildFallbackIcon(ColorScheme colorScheme) {
    return SizedBox.square(
      dimension: UiConstants.spacing24,
      child: Icon(
        Icons.person_outline,
        size: UiConstants.spacing16,
        color: colorScheme.onSurface.withValues(alpha: 0.7),
      ),
    );
  }

  String _formatSpeakerText() =>
      speakers.length > 1
          ? '${speakers.first.name} +${speakers.length - 1}'
          : speakers.first.name;

  @override
  Widget build(BuildContext context) {
    if (speakers.isEmpty) return const SizedBox.shrink();

    final colorScheme = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: UiConstants.spacing8),
      child: Row(
        children: [
          _buildSpeakerImage(colorScheme),
          const SizedBox(width: UiConstants.spacing4),
          Expanded(child: Text(_formatSpeakerText())),
        ],
      ),
    );
  }
}
