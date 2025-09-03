part of 'speakers_cubit.dart';

sealed class SpeakersState extends Equatable {
  const SpeakersState();

  @override
  List<Object> get props => [];
}

final class SpeakersInitial extends SpeakersState {
  const SpeakersInitial();

  @override
  List<Object> get props => [];
}

final class SpeakersLoading extends SpeakersState {
  const SpeakersLoading();

  @override
  List<Object> get props => [];
}

final class SpeakersLoaded extends SpeakersState {
  const SpeakersLoaded(this.speakers);

  final List<SpeakerSummary> speakers;

  @override
  List<Object> get props => [speakers];
}

final class SpeakersError extends SpeakersState {
  const SpeakersError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
