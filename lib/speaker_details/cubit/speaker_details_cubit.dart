import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakers_repository/speakers_repository.dart';

part 'speaker_details_state.dart';

class SpeakerDetailsCubit extends Cubit<SpeakerDetailsState> {
  SpeakerDetailsCubit({
    required SpeakersRepository repository,
    required Speaker speaker,
  }) : _repository = repository,
       super(SpeakerDetailsInitial(speaker));

  final SpeakersRepository _repository;

  Future<void> fetchSpeakerDetails() async {
    final currentSpeaker = state.speaker;
    emit(SpeakerDetailsLoading(currentSpeaker));
    try {
      final speakerDetails = await _repository.getSpeaker(currentSpeaker.id);
      emit(SpeakerDetailsLoaded(speakerDetails));
    } on Exception catch (e) {
      emit(
        SpeakerDetailsError(
          'Failed to load speaker details: $e',
          currentSpeaker,
        ),
      );
    }
  }
}
