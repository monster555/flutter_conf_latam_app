part of 'speaker_details_cubit.dart';

sealed class SpeakerDetailsState extends Equatable {
  const SpeakerDetailsState({required this.speakerSummary});

  /// The initial summary information for the speaker, available from the start.
  final SpeakerSummary speakerSummary;

  @override
  List<Object?> get props => [speakerSummary];
}

/// Initial state before any fetching has begun.
/// The [speakerSummary] is available from the navigation arguments.
class SpeakerDetailsInitial extends SpeakerDetailsState {
  const SpeakerDetailsInitial({required super.speakerSummary});
}

/// State indicating that the full speaker details are being fetched.
/// The [speakerSummary] is still available to display basic info.
class SpeakerDetailsLoading extends SpeakerDetailsState {
  const SpeakerDetailsLoading({required super.speakerSummary});
}

/// State indicating that the full speaker details have been successfully
/// loaded.
///
/// Contains both the initial [speakerSummary] and the full [speakerDetails]
/// details.
class SpeakerDetailsLoaded extends SpeakerDetailsState {
  const SpeakerDetailsLoaded({
    required super.speakerSummary,
    required this.speakerDetails,
  });

  final Speaker speakerDetails;

  @override
  List<Object?> get props => [speakerSummary, speakerDetails];
}

/// State indicating that an error occurred while fetching speaker details.
/// Contains the initial [speakerSummary] and an [errorMessage].
class SpeakerDetailsError extends SpeakerDetailsState {
  const SpeakerDetailsError({
    required super.speakerSummary,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [speakerSummary, errorMessage];
}
