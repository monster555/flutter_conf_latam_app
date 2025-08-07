import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sponsors_repository/sponsors_repository.dart';

part 'sponsors_state.dart';

class SponsorsCubit extends Cubit<SponsorsState> {
  SponsorsCubit({required SponsorsRepository repository})
    : _repository = repository,
      super(const SponsorsInitial());

  final SponsorsRepository _repository;

  Future<void> loadSponsors() => _fetchSponsors();

  Future<void> refreshSponsors() => _fetchSponsors(forceRefresh: true);

  Future<void> _fetchSponsors({bool forceRefresh = false}) async {
    emit(const SponsorsLoading());
    try {
      final sponsors = await _repository.getSponsors(
        forceRefresh: forceRefresh,
      );
      final groupedSponsors = _groupSponsorsByLevel(sponsors);

      emit(SponsorsLoaded(groupedSponsors));
    } on Exception catch (e) {
      emit(SponsorsError('Failed to load sponsors: $e'));
    }
  }

  Map<SponsorTier, List<Sponsor>> _groupSponsorsByLevel(
    List<Sponsor> sponsors,
  ) {
    final result = <SponsorTier, List<Sponsor>>{};

    for (final sponsor in sponsors) {
      if (!result.containsKey(sponsor.level)) {
        result[sponsor.level] = [];
      }
      result[sponsor.level]!.add(sponsor);
    }

    return result;
  }
}
