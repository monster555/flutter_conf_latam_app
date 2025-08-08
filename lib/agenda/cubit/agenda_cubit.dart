import 'package:agenda_repository/agenda_repository.dart';
import 'package:conf_shared_models/conf_shared_models.dart'
    show ScheduleDay, Session, TimeSlot;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'agenda_state.dart';

class AgendaCubit extends Cubit<AgendaState> {
  AgendaCubit({required AgendaRepository repository})
    : _repository = repository,
      super(AgendaInitial());

  final AgendaRepository _repository;

  Future<void> loadAgenda({required String languageCode}) async {
    await _fetchAndProcessAgenda(
      languageCode: languageCode,
      forceRefresh: false,
    );
  }

  Future<void> refreshAgenda({required String languageCode}) async {
    await _fetchAndProcessAgenda(
      languageCode: languageCode,
      forceRefresh: true,
    );
  }

  void selectDayByDate(DateTime date) {
    final currentState = state;
    if (currentState is AgendaLoaded) {
      final dayIndex = currentState.dayIndexForDate(date);
      if (dayIndex != -1) {
        _selectDay(dayIndex);
      }
    }
  }

  Future<void> _fetchAndProcessAgenda({
    required String languageCode,
    required bool forceRefresh,
  }) async {
    emit(const AgendaLoading());

    try {
      final schedule = await _repository.getAgenda(
        languageCode: languageCode,
        forceRefresh: forceRefresh,
      );

      if (schedule.isEmpty) {
        emit(const AgendaEmpty('No sessions available'));
        return;
      }

      emit(AgendaLoaded(days: schedule, selectedDayIndex: 0));
    } on Exception catch (e) {
      emit(AgendaError(e.toString()));
    }
  }

  void _selectDay(int dayIndex) {
    final currentState = state;
    if (currentState is AgendaLoaded &&
        currentState.isValidDayIndex(dayIndex)) {
      emit(AgendaLoaded(days: currentState.days, selectedDayIndex: dayIndex));
    }
  }
}
