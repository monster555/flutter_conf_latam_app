part of 'sponsors_cubit.dart';

sealed class SponsorsState extends Equatable {
  const SponsorsState();

  @override
  List<Object> get props => [];
}

final class SponsorsInitial extends SponsorsState {
  const SponsorsInitial();

  @override
  List<Object> get props => [];
}

final class SponsorsLoading extends SponsorsState {
  const SponsorsLoading();

  @override
  List<Object> get props => [];
}

final class SponsorsLoaded extends SponsorsState {
  const SponsorsLoaded(this.groupedSponsors);

  final Map<SponsorTier, List<Sponsor>> groupedSponsors;

  @override
  List<Object> get props => [groupedSponsors];
}

final class SponsorsError extends SponsorsState {
  const SponsorsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
