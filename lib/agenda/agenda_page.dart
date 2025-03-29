import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/extensions/navigator_extensions.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/mock/mock_data.dart';
import 'package:flutter_conf_latam/session_details/session_details.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  Map<DateTime, List<Session>> _sessionsByDate = {};
  List<DateTime> _dates = [];
  DateTime? _selectedDate;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchAgendaData();
  }

  Future<void> _fetchAgendaData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Simulate API delay
      await Future<void>.delayed(const Duration(milliseconds: 800));

      // Get sessions (replace with real API call later)
      final sessions = ConferenceMockData.getSessionsList();

      // Group sessions by date
      final sessionsByDate = <DateTime, List<Session>>{};

      for (final session in sessions) {
        // Extract just the date part
        final date = DateTime(
          session.startTime.year,
          session.startTime.month,
          session.startTime.day,
        );

        sessionsByDate.putIfAbsent(date, () => []);
        sessionsByDate[date]!.add(session);
      }

      // Sort sessions by time within each date
      for (final date in sessionsByDate.keys) {
        sessionsByDate[date]!.sort(
          (a, b) => a.startTime.compareTo(b.startTime),
        );
      }

      // Sort dates chronologically
      final dates = sessionsByDate.keys.toList()..sort();

      setState(() {
        _sessionsByDate = sessionsByDate;
        _dates = dates;
        _selectedDate = dates.isNotEmpty ? dates.first : null;
        _isLoading = false;
      });
      // This just simulates an API call which won't be here in the future
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load agenda: $e';
        _isLoading = false;
      });
    }
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final padding = context.padding;
    final topPadding = padding.top;
    final bottomPadding = padding.bottom;

    if (_isLoading) {
      return Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Semantics(
          label: l10n.stateLoadingAgenda,
          child: const Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_errorMessage != null) {
      return Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Semantics(
          label: _errorMessage,
          liveRegion: true,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_errorMessage!),
                const SizedBox(height: UiConstants.spacing16),
                ElevatedButton(
                  onPressed: _fetchAgendaData,
                  child: Text(l10n.actionRetry),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_dates.isEmpty) {
      return Semantics(
        label: l10n.errorSessionsNone,
        child: FeedbackWidget(
          fullScreen: true,
          icon: Icons.event_busy_outlined,
          message: l10n.errorSessionsNone,
        ),
      );
    }

    final selectedDate = _selectedDate!;
    final sessions = _sessionsByDate[selectedDate] ?? [];

    final formattedDate = DateFormatService.formatFullDate(
      selectedDate,
      context,
    );

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            UiConstants.spacing16,
            topPadding + UiConstants.spacing16,
            UiConstants.spacing16,
            0,
          ),
          sliver: SliverToBoxAdapter(
            child: Semantics(
              header: true,
              child: DatesTabs(
                availableDates: _dates,
                selectedDate: selectedDate,
                onDateSelected: _onDateSelected,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            UiConstants.spacing16,
            0,
            UiConstants.spacing16,
            bottomPadding,
          ),
          sliver: SessionsList(
            sessions: sessions,
            noSessionsMessage: l10n.errorSessionsNoneForDay(formattedDate),
            sessionLevelLabels: {
              SessionLevel.basic: l10n.sessionLevelBasic,
              SessionLevel.intermediate: l10n.sessionLevelIntermediate,
              SessionLevel.advanced: l10n.sessionLevelAdvanced,
              SessionLevel.expert: l10n.sessionLevelExpert,
            },
            showSessionDescriptions: true,
            onSessionTap:
                (session) => context.push<void>(SessionDetailsPage(session)),
          ),
        ),
      ],
    );
  }
}
