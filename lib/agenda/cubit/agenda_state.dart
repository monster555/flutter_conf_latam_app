part of 'agenda_cubit.dart';

sealed class AgendaState extends Equatable {
  const AgendaState();

  @override
  List<Object> get props => [];
}

final class AgendaInitial extends AgendaState {}

final class AgendaLoading extends AgendaState {
  const AgendaLoading();
}

final class AgendaLoaded extends AgendaState {
  const AgendaLoaded({required this.days, required this.selectedDayIndex});

  final List<ScheduleDay> days;
  final int selectedDayIndex;

  ScheduleDay get selectedDay => days[selectedDayIndex];

  List<Session> get selectedDaySessions {
    final sessions = <Session>[];
    for (final slot in selectedDay.slots) {
      sessions.addAll(slot.sessions);
    }
    return sessions;
  }

  List<DateTime> get availableDates => days.map((day) => day.date).toList();

  List<TimeSlot> get selectedDaySlots => selectedDay.slots;

  Map<TimeSlot, List<Session>> get sessionsBySlot {
    final result = <TimeSlot, List<Session>>{};
    for (final slot in selectedDay.slots) {
      result[slot] = slot.sessions;
    }
    return result;
  }

  int dayIndexForDate(DateTime date) {
    return days.indexWhere(
      (day) =>
          day.date.year == date.year &&
          day.date.month == date.month &&
          day.date.day == date.day,
    );
  }

  bool isValidDayIndex(int index) => index >= 0 && index < days.length;

  @override
  List<Object> get props => [days, selectedDayIndex];
}

final class AgendaEmpty extends AgendaState {
  const AgendaEmpty(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class AgendaError extends AgendaState {
  const AgendaError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
