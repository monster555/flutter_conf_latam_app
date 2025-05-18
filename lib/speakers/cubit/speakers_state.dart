part of 'speakers_cubit.dart';

sealed class SpeakersState extends Equatable {
  const SpeakersState();

  @override
  List<Object> get props => [];
}

class SpeakersInitial extends SpeakersState {
  const SpeakersInitial();

  @override
  List<Object> get props => [];
}

class SpeakersLoading extends SpeakersState {
  const SpeakersLoading();

  @override
  List<Object> get props => [];
}

class SpeakersLoaded extends SpeakersState {
  const SpeakersLoaded(this.speakers);

  final List<SpeakerSummary> speakers;

  @override
  List<Object> get props => [speakers];
}

class SpeakersError extends SpeakersState {
  const SpeakersError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
