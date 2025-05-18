import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakers_repository/speakers_repository.dart';

part 'speaker_details_state.dart';

class SpeakerDetailsCubit extends Cubit<SpeakerDetailsState> {
  SpeakerDetailsCubit({
    required SpeakersRepository repository,
    required SpeakerSummary summary,
  }) : _repository = repository,
       super(SpeakerDetailsInitial(speakerSummary: summary));

  final SpeakersRepository _repository;

  Future<void> fetchSpeakerDetails({required String languageCode}) async {
    final speakerSummary = state.speakerSummary;
    emit(SpeakerDetailsLoading(speakerSummary: speakerSummary));

    try {
      final speakerDetails = await _repository.getSpeakerById(
        speakerSummary.id,
        languageCode: languageCode,
      );
      emit(
        SpeakerDetailsLoaded(
          speakerSummary: speakerSummary,
          speakerDetails: speakerDetails,
        ),
      );
    } on Exception catch (e) {
      emit(
        SpeakerDetailsError(
          speakerSummary: speakerSummary,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
