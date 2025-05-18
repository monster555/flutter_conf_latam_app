import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakers_repository/speakers_repository.dart';

part 'speakers_state.dart';

class SpeakersCubit extends Cubit<SpeakersState> {
  SpeakersCubit({required SpeakersRepository repository})
    : _repository = repository,
      super(const SpeakersInitial());

  final SpeakersRepository _repository;

  Future<void> fetchSpeakers({required String languageCode}) async {
    emit(const SpeakersLoading());
    try {
      final speakers = await _repository.getSpeakers(
        languageCode: languageCode,
      );
      emit(SpeakersLoaded(speakers));
    } on Exception catch (e) {
      emit(SpeakersError('Failed to load speakers: $e'));
    }
  }
}
