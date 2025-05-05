part of 'speaker_details_cubit.dart';

sealed class SpeakerDetailsState extends Equatable {
  const SpeakerDetailsState(this.speaker);

  final Speaker speaker;

  @override
  List<Object> get props => [speaker];
}

class SpeakerDetailsInitial extends SpeakerDetailsState {
  const SpeakerDetailsInitial(super.speaker);
}

class SpeakerDetailsLoading extends SpeakerDetailsState {
  const SpeakerDetailsLoading(super.speaker);
}

class SpeakerDetailsLoaded extends SpeakerDetailsState {
  const SpeakerDetailsLoaded(super.speaker);
}

class SpeakerDetailsError extends SpeakerDetailsState {
  const SpeakerDetailsError(this.message, super.speaker);

  final String message;

  @override
  List<Object> get props => [message, speaker];
}
