part of 'sponsors_cubit.dart';

sealed class SponsorsState extends Equatable {
  const SponsorsState();

  @override
  List<Object> get props => [];
}

class SponsorsInitial extends SponsorsState {
  const SponsorsInitial();

  @override
  List<Object> get props => [];
}

class SponsorsLoading extends SponsorsState {
  const SponsorsLoading();

  @override
  List<Object> get props => [];
}

class SponsorsLoaded extends SponsorsState {
  const SponsorsLoaded(this.groupedSponsors);

  final Map<SponsorTier, List<Sponsor>> groupedSponsors;
  // final List<Sponsor> sponsors;

  @override
  List<Object> get props => [groupedSponsors];
}

class SponsorsError extends SponsorsState {
  const SponsorsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
