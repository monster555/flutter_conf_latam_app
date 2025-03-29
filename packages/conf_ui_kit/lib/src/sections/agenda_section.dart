import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/lists/sessions_list.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:conf_ui_kit/src/widgets/dates_tabs.dart';
import 'package:flutter/material.dart';

class AgendaSection extends StatefulWidget {
  const AgendaSection({
    required this.sessions,
    required this.sectionTitle,
    this.sessionLevelLabels = const {},
    this.noSessionsMessage,
    this.formatNoSessionsForDate,
    this.showSessionDescriptions = false,
    this.onSessionTap,
    this.hideWhenEmpty = false,
    super.key,
  }) : assert(
         noSessionsMessage != null || formatNoSessionsForDate != null,
         'Either noSessionsMessage or formatNoSessionsForDate must be provided',
       );

  final List<Session> sessions;
  final Map<SessionLevel, String> sessionLevelLabels;
  final String? noSessionsMessage;
  final String Function(DateTime date)? formatNoSessionsForDate;
  final String sectionTitle;
  final bool showSessionDescriptions;
  final void Function(Session)? onSessionTap;
  final bool hideWhenEmpty;

  @override
  State<AgendaSection> createState() => _AgendaSectionState();
}

class _AgendaSectionState extends State<AgendaSection> {
  late Map<DateTime, List<Session>> _sessionsByDate;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _groupSessionsByDate();
  }

  @override
  void didUpdateWidget(AgendaSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sessions != widget.sessions) {
      _groupSessionsByDate();
    }
  }

  void _groupSessionsByDate() {
    _sessionsByDate = {};

    for (final session in widget.sessions) {
      final date = DateTime(
        session.startTime.year,
        session.startTime.month,
        session.startTime.day,
      );

      if (!_sessionsByDate.containsKey(date)) {
        _sessionsByDate[date] = [];
      }
      _sessionsByDate[date]!.add(session);
    }

    for (final date in _sessionsByDate.keys) {
      _sessionsByDate[date]!.sort((a, b) => a.startTime.compareTo(b.startTime));
    }

    final dates = _sessionsByDate.keys.toList()..sort();
    _selectedDate = dates.isNotEmpty ? dates.first : DateTime.now();
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sessions.isEmpty && widget.hideWhenEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    final availableDates = _sessionsByDate.keys.toList()..sort();
    final selectedSessions = _sessionsByDate[_selectedDate] ?? [];

    final emptyMessage =
        widget.noSessionsMessage ??
        widget.formatNoSessionsForDate!(_selectedDate);

    return SliverMainAxisGroup(
      slivers: [
        if (widget.sectionTitle.isNotEmpty)
          SliverToBoxAdapter(
            child: Semantics(
              header: true,
              label: widget.sectionTitle,
              child: Text(
                widget.sectionTitle,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        const SliverToBoxAdapter(
          child: SizedBox(height: UiConstants.spacing16),
        ),
        SliverToBoxAdapter(
          child: DatesTabs(
            availableDates: availableDates,
            selectedDate: _selectedDate,
            onDateSelected: _onDateSelected,
          ),
        ),

        SessionsList(
          sessions: selectedSessions,
          sessionLevelLabels: widget.sessionLevelLabels,
          showSessionDescriptions: widget.showSessionDescriptions,
          onSessionTap: widget.onSessionTap,
          noSessionsMessage: emptyMessage,
        ),
      ],
    );
  }
}
