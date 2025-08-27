import 'package:conf_core/conf_core.dart';
import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/agenda/cubit/agenda_cubit.dart';
import 'package:flutter_conf_latam/extensions/navigator_extensions.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/session_details/session_details.dart';

class AgendaView extends StatelessWidget {
  const AgendaView({super.key});

  static bool _isLoadingSelector(AgendaCubit cubit) =>
      cubit.state is AgendaLoading;

  static String? _errorMessageSelector(AgendaCubit cubit) {
    final state = cubit.state;
    if (state case AgendaError(:final message)) return message;
    return null;
  }

  static bool _isEmptySelector(AgendaCubit cubit) => cubit.state is AgendaEmpty;

  static String? _emptyMessageSelector(AgendaCubit cubit) {
    final state = cubit.state;
    if (state case AgendaEmpty(:final message)) return message;
    return null;
  }

  static List<DateTime> _availableDatesSelector(AgendaCubit cubit) {
    final state = cubit.state;
    if (state case AgendaLoaded(:final availableDates)) return availableDates;
    return const <DateTime>[];
  }

  static DateTime? _selectedDateSelector(AgendaCubit cubit) {
    final state = cubit.state;
    if (state case AgendaLoaded(selectedDay: final day)) return day.date;
    return null;
  }

  static List<TimeSlot> _slotsSelector(AgendaCubit cubit) {
    final state = cubit.state;
    if (state case AgendaLoaded(:final selectedDaySlots)) {
      return selectedDaySlots;
    }
    return const <TimeSlot>[];
  }

  static Map<TimeSlot, List<Session>> _sessionsBySlotSelector(
    AgendaCubit cubit,
  ) {
    final state = cubit.state;
    if (state case AgendaLoaded(:final sessionsBySlot)) return sessionsBySlot;
    return const <TimeSlot, List<Session>>{};
  }

  Widget _buildLoadingState(AppLocalizations l10n, EdgeInsets padding) {
    final topPadding = padding.top + kToolbarHeight;

    return Center(
      child: Semantics(
        liveRegion: true,
        label: l10n.stateLoadingAgenda,
        child: Padding(
          padding: EdgeInsets.only(top: topPadding),
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    AppLocalizations l10n,
    String errorMessage,
    EdgeInsets padding,
  ) {
    final topPadding = padding.top + kToolbarHeight;

    return Center(
      child: Semantics(
        liveRegion: true,
        label: errorMessage,
        child: Padding(
          padding: EdgeInsets.only(top: topPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(errorMessage),
              const SizedBox(height: UiConstants.spacing16),
              ElevatedButton(
                onPressed: () {
                  final languageCode = context.languageCode;
                  context.read<AgendaCubit>().refreshAgenda(
                    languageCode: languageCode,
                  );
                },
                child: Text(l10n.actionRetry),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n, String? message) {
    final displayMessage = message ?? l10n.errorSessionsNone;

    return Semantics(
      label: displayMessage,
      child: FeedbackWidget(
        fullScreen: true,
        icon: Icons.event_busy_outlined,
        message: displayMessage,
      ),
    );
  }

  Widget _buildAgendaContent(
    BuildContext context,
    AppLocalizations l10n,
    EdgeInsets padding,
    DateFormatter formatter, {
    required List<DateTime> availableDates,
    required DateTime selectedDate,
    required List<TimeSlot> slots,
    required Map<TimeSlot, List<Session>> sessionsBySlot,
  }) {
    return CustomScrollView(
      key: const PageStorageKey<String>('agenda_list'),
      slivers: [
        SliverPinnedHeader(
          child: AgendaHeader(
            availableDates: availableDates,
            selectedDate: selectedDate,
            onDateSelected:
                (date) => _onDateSelected(context, date, l10n, formatter),
          ),
        ),
        SlotsList(
          slots: slots,
          sessionsBySlot: sessionsBySlot,
          sessionLevelLabels: {
            SessionLevel.basic: l10n.sessionLevelBasic,
            SessionLevel.intermediate: l10n.sessionLevelIntermediate,
            SessionLevel.advanced: l10n.sessionLevelAdvanced,
            SessionLevel.expert: l10n.sessionLevelExpert,
          },
          onSessionTap:
              (session) => context.push<void>(SessionDetailsPage(session)),
          noSessionsMessage: l10n.errorSessionsNoneForDay(
            formatter.formatFullDate(selectedDate),
          ),
        ),
        SliverPadding(padding: EdgeInsets.only(bottom: padding.bottom)),
      ],
    );
  }

  void _onDateSelected(
    BuildContext context,
    DateTime date,
    AppLocalizations l10n,
    DateFormatter formatter,
  ) {
    context.read<AgendaCubit>().selectDayByDate(date);
    _announceSelectedDate(date, l10n, formatter);
  }

  void _announceSelectedDate(
    DateTime date,
    AppLocalizations l10n,
    DateFormatter formatter,
  ) {
    SemanticsService.announce(
      l10n.dateSelectedAnnouncement(formatter.formatFullDate(date)),
      TextDirection.ltr,
    );
  }

  @visibleForTesting
  Widget buildBodyContent(
    BuildContext context, {
    required bool isLoading,
    required String? errorMessage,
    required bool isEmpty,
    required String? emptyMessage,
    required List<DateTime> availableDates,
    required DateTime? selectedDate,
    required List<TimeSlot> slots,
    required Map<TimeSlot, List<Session>> sessionsBySlot,
    required AppLocalizations l10n,
    required EdgeInsets padding,
    required DateFormatter formatter,
  }) {
    return switch ((isLoading, errorMessage, isEmpty, selectedDate)) {
      (true, _, _, _) => _buildLoadingState(l10n, padding),
      (false, final String errorMessage, _, _) => _buildErrorState(
        context,
        l10n,
        errorMessage,
        padding,
      ),
      (false, null, true, _) => _buildEmptyState(l10n, emptyMessage),
      (false, null, false, final DateTime date) => _buildAgendaContent(
        context,
        l10n,
        padding,
        formatter,
        availableDates: availableDates,
        selectedDate: date,
        slots: slots,
        sessionsBySlot: sessionsBySlot,
      ),
      _ => _buildEmptyState(l10n, emptyMessage),
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final padding = context.padding;
    final formatter = DateFormatService.withContext(context);

    final isLoading = context.select<AgendaCubit, bool>(_isLoadingSelector);
    final errorMessage = context.select<AgendaCubit, String?>(
      _errorMessageSelector,
    );
    final isEmpty = context.select<AgendaCubit, bool>(_isEmptySelector);
    final emptyMessage = context.select<AgendaCubit, String?>(
      _emptyMessageSelector,
    );
    final availableDates = context.select<AgendaCubit, List<DateTime>>(
      _availableDatesSelector,
    );
    final selectedDate = context.select<AgendaCubit, DateTime?>(
      _selectedDateSelector,
    );

    final slots = context.select<AgendaCubit, List<TimeSlot>>(_slotsSelector);
    final sessionsBySlot = context
        .select<AgendaCubit, Map<TimeSlot, List<Session>>>(
          _sessionsBySlotSelector,
        );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: FrostedAppBar(title: Text(l10n.agendaTabLabel)),
      body: RefreshIndicator(
        edgeOffset: padding.top + kToolbarHeight,
        onRefresh: () async {
          final languageCode = context.languageCode;
          await context.read<AgendaCubit>().refreshAgenda(
            languageCode: languageCode,
          );
        },
        child: buildBodyContent(
          context,
          isLoading: isLoading,
          errorMessage: errorMessage,
          isEmpty: isEmpty,
          emptyMessage: emptyMessage,
          availableDates: availableDates,
          selectedDate: selectedDate,
          slots: slots,
          sessionsBySlot: sessionsBySlot,
          l10n: l10n,
          padding: padding,
          formatter: formatter,
        ),
      ),
    );
  }
}
