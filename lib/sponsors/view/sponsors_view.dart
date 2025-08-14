import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/sponsors/cubit/sponsors_cubit.dart';

class SponsorsView extends StatelessWidget {
  const SponsorsView({super.key});

  static const Key _sponsorsListKey = PageStorageKey<String>('sponsors_list');
  static const _emptySponsorsMap = <SponsorTier, List<Sponsor>>{};

  static bool _isLoadingSelector(SponsorsCubit cubit) =>
      cubit.state is SponsorsLoading;

  static String? _errorMessageSelector(SponsorsCubit cubit) {
    final state = cubit.state;
    if (state case SponsorsError(:final message)) return message;
    return null;
  }

  static Map<SponsorTier, List<Sponsor>> _sponsorsSelector(
    SponsorsCubit cubit,
  ) {
    final state = cubit.state;
    if (state case SponsorsLoaded(:final groupedSponsors)) {
      return groupedSponsors;
    }
    return _emptySponsorsMap;
  }

  void _handleRetryButtonPressed(BuildContext context) =>
      context.read<SponsorsCubit>().refreshSponsors();

  Future<void> _handleRefreshIndicatorPull(BuildContext context) async {
    await context.read<SponsorsCubit>().refreshSponsors();
  }

  Widget _buildLoadingState(AppLocalizations l10n, EdgeInsets padding) {
    final topPadding = padding.top + kToolbarHeight;
    return Center(
      child: Semantics(
        liveRegion: true,
        label: l10n.stateLoadingSponsors,
        child: Padding(
          padding: EdgeInsets.only(top: topPadding),
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    AppLocalizations l10n,
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
              const SizedBox(height: UiConstants.spacing16),
              ElevatedButton(
                onPressed: () => _handleRetryButtonPressed(context),
                child: Text(l10n.actionRetry),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Semantics(
      label: l10n.errorSponsorsNone,
      child: FeedbackWidget(
        fullScreen: true,
        icon: Icons.business_outlined,
        message: l10n.errorSponsorsNone,
      ),
    );
  }

  String _getTierTitle(SponsorTier tier, AppLocalizations l10n) {
    return switch (tier) {
      SponsorTier.platinum => l10n.sponsorTierPlatinum,
      SponsorTier.gold => l10n.sponsorTierGold,
      SponsorTier.silver => l10n.sponsorTierSilver,
      SponsorTier.inKind => l10n.sponsorTierInkind,
      SponsorTier.senior => l10n.sponsorTierSenior,
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
      label: l10n.sponsorsTabLabel,
      explicitChildNodes: true,
      child: CustomScrollView(
        key: _sponsorsListKey,
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: topPadding)),
          ...sortedTiers
              .where((tier) => groupedSponsors[tier]!.isNotEmpty)
              .map(
                (tier) => SliverToBoxAdapter(
                  child: SponsorsGroup(
                    title: _getTierTitle(tier, l10n),
                    sponsors: groupedSponsors[tier]!,
                  ),
                ),
              ),
          SliverToBoxAdapter(child: SizedBox(height: padding.bottom)),
        ],
      ),
    );
  }

  @visibleForTesting
  Widget buildBodyContent(
    BuildContext context, {
    required AppLocalizations l10n,
    required EdgeInsets padding,
    required bool isLoading,
    required String? errorMessage,
    required Map<SponsorTier, List<Sponsor>> sponsors,
  }) {
    return switch ((isLoading, errorMessage, sponsors.isEmpty)) {
      (true, _, _) => _buildLoadingState(l10n, padding),
      (false, final String msg, _) => _buildErrorState(
        context,
        l10n,
        msg,
        padding,
      ),
      (false, null, true) => _buildEmptyState(l10n),
      _ => _buildSponsorsList(l10n, sponsors, padding),
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final padding = context.padding;

    final isLoading = context.select<SponsorsCubit, bool>(_isLoadingSelector);
    final errorMessage = context.select<SponsorsCubit, String?>(
      _errorMessageSelector,
    );
    final sponsors = context
        .select<SponsorsCubit, Map<SponsorTier, List<Sponsor>>>(
          _sponsorsSelector,
        );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: FrostedAppBar(title: Text(l10n.sponsorsTabLabel)),
      body: RefreshIndicator(
        edgeOffset: padding.top + kToolbarHeight,
        onRefresh: () => _handleRefreshIndicatorPull(context),
        child: buildBodyContent(
          context,
          l10n: l10n,
          padding: padding,
          isLoading: isLoading,
          errorMessage: errorMessage,
          sponsors: sponsors,
        ),
      ),
    );
  }
}
