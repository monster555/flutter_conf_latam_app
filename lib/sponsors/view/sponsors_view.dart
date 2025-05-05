import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/sponsors/cubit/sponsors_cubit.dart';

class SponsorsView extends StatelessWidget {
  const SponsorsView({super.key});

  static bool isLoadingSelector(SponsorsCubit cubit) =>
      cubit.state is SponsorsLoading;

  static String? errorMessageSelector(SponsorsCubit cubit) {
    final state = cubit.state;
    if (state case SponsorsError(:final message)) return message;
    return null;
  }

  static Map<SponsorTier, List<Sponsor>> sponsorsSelector(SponsorsCubit cubit) {
    final state = cubit.state;
    if (state case SponsorsLoaded(:final groupedSponsors)) {
      return groupedSponsors;
    }
    return const <SponsorTier, List<Sponsor>>{};
  }

  Widget _buildLoadingState(AppLocalizations l10n, EdgeInsets padding) {
    final topPadding = padding.top + kToolbarHeight;
    return Center(
      child: Semantics(
        liveRegion: true,
        label: l10n.stateLoadingSpeakers,
        child: Padding(
          padding: EdgeInsets.only(top: topPadding),
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    String errorMessage,
    EdgeInsets padding,
  ) {
    final topPadding = padding.top + kToolbarHeight;
    return Center(
      child: Semantics(
        liveRegion: true,
        label: errorMessage,
        child: Padding(
          padding: EdgeInsets.only(top: topPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(errorMessage),
              const ExcludeSemantics(
                child: SizedBox(height: UiConstants.spacing16),
              ),
              ElevatedButton(
                onPressed: context.read<SponsorsCubit>().fetchSponsors,
                child: Text(context.l10n.actionRetry),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Semantics(
      label: l10n.errorSpeakersNone,
      child: FeedbackWidget(
        fullScreen: true,
        icon: Icons.person_off_outlined,
        message: l10n.errorSpeakersNone,
      ),
    );
  }

  String _getTierTitle(SponsorTier tier, AppLocalizations l10n) {
    return switch (tier) {
      SponsorTier.platinum => l10n.sponsorTierPlatinum,
      SponsorTier.gold => l10n.sponsorTierGold,
      SponsorTier.silver => l10n.sponsorTierSilver,
      SponsorTier.inkind => l10n.sponsorTierInkind,
      SponsorTier.other => l10n.sponsorTierOther,
    };
  }

  Widget _buildSponsorsList(
    AppLocalizations l10n,
    Map<SponsorTier, List<Sponsor>> groupedSponsors,
    EdgeInsets padding,
  ) {
    final topPadding = padding.top + kToolbarHeight + UiConstants.spacing16;
    final sortedTiers =
        groupedSponsors.keys.toList()
          ..sort((a, b) => a.sortPriority.compareTo(b.sortPriority));

    return Semantics(
      container: true,
      label: l10n.speakersTabLabel,
      explicitChildNodes: true,
      child: CustomScrollView(
        key: const PageStorageKey<String>('sponsors_list'),
        slivers: [
          SliverToBoxAdapter(
            child: ExcludeSemantics(child: SizedBox(height: topPadding)),
          ),
          ...sortedTiers
              .where((tier) => groupedSponsors[tier]!.isNotEmpty)
              .map(
                (tier) => SliverToBoxAdapter(
                  child: GroupedSponsors(
                    title: _getTierTitle(tier, l10n),
                    sponsors: groupedSponsors[tier]!,
                  ),
                ),
              ),
          SliverToBoxAdapter(
            child: ExcludeSemantics(child: SizedBox(height: padding.bottom)),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final l10n = context.l10n;
    final padding = context.padding;

    final isLoading = context.select<SponsorsCubit, bool>(isLoadingSelector);
    if (isLoading) return _buildLoadingState(l10n, padding);

    final errorMessage = context.select<SponsorsCubit, String?>(
      errorMessageSelector,
    );
    if (errorMessage != null) {
      return _buildErrorState(context, errorMessage, padding);
    }

    final sponsors = context
        .select<SponsorsCubit, Map<SponsorTier, List<Sponsor>>>(
          sponsorsSelector,
        );

    if (sponsors.isEmpty) return _buildEmptyState(l10n);

    return _buildSponsorsList(l10n, sponsors, padding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: FrostedAppBar(title: Text(context.l10n.sponsorsTabLabel)),
      body: _buildContent(context),
    );
  }
}

class GroupedSponsors extends StatelessWidget {
  const GroupedSponsors({
    required this.title,
    required this.sponsors,
    super.key,
  });

  final String title;
  final List<Sponsor> sponsors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: UiConstants.spacing16,
        vertical: UiConstants.spacing8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: title),
          SizedBox(
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(UiConstants.spacing8),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate logo width based on screen size
                    // Aim for 2 logos per row on phones, 3-4 on larger devices
                    final width = constraints.maxWidth;
                    final itemWidth =
                        width < 600 ? width / 2 - 24 : width / 3 - 32;

                    return Wrap(
                      spacing: UiConstants.spacing16,
                      runSpacing: UiConstants.spacing16,
                      alignment: WrapAlignment.center,
                      children:
                          sponsors.map((sponsor) {
                            return SizedBox(
                              width: itemWidth,
                              height: 80,
                              child: Center(
                                child: SponsorLogo(
                                  imageUrl: sponsor.logo,
                                  sponsorName: sponsor.name,
                                  height: 60,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          }).toList(),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GroupedSponsors1 extends StatelessWidget {
  const GroupedSponsors1({
    required this.title,
    required this.sponsors,
    super.key,
  });

  final String title;
  final List<Sponsor> sponsors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: UiConstants.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: title),
          Card(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ...sponsors.map(
                  (sponsor) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: UiConstants.spacing2,
                    ),
                    child: SponsorLogo(
                      imageUrl: sponsor.logo,
                      sponsorName: sponsor.name,
                      // width: width / 3,
                      // height: 40,
                    ),
                  ),
                ),
                // for (final sponsor in sponsors)
                //   Padding(
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: UiConstants.spacing2,
                //     ),
                //     child: SponsorLogo(
                //       imageUrl: sponsor.logo,
                //       sponsorName: sponsor.name,
                //       height: 40,
                //     ),
                //   ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
