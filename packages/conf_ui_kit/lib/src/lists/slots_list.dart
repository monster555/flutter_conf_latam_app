import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:conf_ui_kit/src/headers/slot_header.dart';
import 'package:flutter/material.dart';

class SlotsList extends StatelessWidget {
  const SlotsList({
    required this.slots,
    required this.sessionsBySlot,
    required this.noSessionsMessage,
    this.sessionLevelLabels = const {},
    this.showSessionDescriptions = false,
    this.onSessionTap,
    super.key,
  });

  static const Widget _separator = SizedBox(height: UiConstants.spacing8);
  static const _horizontalPadding = EdgeInsets.symmetric(
    horizontal: UiConstants.spacing16,
  );

  final List<TimeSlot> slots;
  final Map<TimeSlot, List<Session>> sessionsBySlot;
  final Map<SessionLevel, String> sessionLevelLabels;
  final String noSessionsMessage;
  final bool showSessionDescriptions;
  final void Function(Session)? onSessionTap;

  Widget _buildEmptyState(TextTheme textTheme, ColorScheme colorScheme) {
    return SliverToBoxAdapter(
      child: Semantics(
        label: noSessionsMessage,
        child: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(UiConstants.spacing24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_busy,
                  size: UiConstants.iconSizeXLarge,
                  color: colorScheme.primary.withValues(alpha: 0.5),
                ),
                const SizedBox(height: UiConstants.spacing16),
                Text(
                  noSessionsMessage,
                  style: textTheme.titleSmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSlotSections() {
    if (slots.isEmpty) return const <Widget>[];

    final sections = <Widget>[];
    final slotCount = slots.length;

    for (var i = 0; i < slotCount; i++) {
      final slot = slots[i];
      final sessions = sessionsBySlot[slot];

      if (sessions == null) continue;

      sections.add(
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            UiConstants.spacing16,
            i == 0 ? UiConstants.spacing8 : UiConstants.spacing16,
            UiConstants.spacing16,
            0,
          ),
          sliver: SliverToBoxAdapter(child: SlotHeader(timeSlot: slot)),
        ),
      );

      if (sessions.isNotEmpty) {
        sections.add(
          SliverPadding(
            padding: _horizontalPadding,
            sliver: SliverList.separated(
              itemCount: sessions.length,
              itemBuilder: (context, sessionIndex) {
                if (sessionIndex >= sessions.length) {
                  return const SizedBox.shrink();
                }

                final session = sessions[sessionIndex];

                return SessionCard(
                  session: session,
                  levelLabels: sessionLevelLabels,
                  showDescription: showSessionDescriptions,
                  onTap: () => onSessionTap?.call(session),
                );
              },
              separatorBuilder: _buildSeparator,
            ),
          ),
        );
      }
    }

    return sections;
  }

  Widget _buildSeparator(BuildContext context, int index) => _separator;

  @override
  Widget build(BuildContext context) {
    if (slots.isEmpty) {
      final textTheme = context.textTheme;
      final colorScheme = context.colorScheme;

      return SliverMainAxisGroup(
        slivers: [_buildEmptyState(textTheme, colorScheme)],
      );
    }

    final slotSections = _buildSlotSections();

    return SliverMainAxisGroup(slivers: slotSections);
  }
}
