import 'package:conf_core/conf_core.dart';
import 'package:conf_shared_models/conf_shared_models.dart' show SpeakerSummary;
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/extensions/navigator_extensions.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/speaker_details/speaker_details.dart';
import 'package:flutter_conf_latam/speakers/cubit/speakers_cubit.dart';

class SpeakersView extends StatelessWidget {
  const SpeakersView({super.key});

  static const Key _retryButtonKey = Key('speakers_retry_button');
  static const Key _speakersListKey = PageStorageKey<String>('speakers_list');
  static const List<SpeakerSummary> _emptySpeakersList = [];

  static bool _isLoadingSelector(SpeakersCubit cubit) =>
      cubit.state is SpeakersLoading;

  static String? _errorMessageSelector(SpeakersCubit cubit) {
    final state = cubit.state;
    if (state case SpeakersError(:final message)) return message;
    return null;
  }

  static List<SpeakerSummary> _speakersSelector(SpeakersCubit cubit) {
    final state = cubit.state;
    if (state case SpeakersLoaded(:final speakers)) return speakers;
    return _emptySpeakersList;
  }

  Future<void> _refreshSpeakers(BuildContext context) async {
    final languageCode = context.languageCode;
    await context.read<SpeakersCubit>().refreshSpeakers(
      languageCode: languageCode,
    );
  }

  void _handleRetryButtonPressed(BuildContext context) =>
      _refreshSpeakers(context);

  Future<void> _handleRefreshIndicatorPull(BuildContext context) =>
      _refreshSpeakers(context);

  void _handleSpeakerTap(BuildContext context, SpeakerSummary speaker) =>
      context.push<void>(SpeakerDetailsPage(speaker));

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
                key: _retryButtonKey,
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
      label: l10n.errorSpeakersNone,
      child: FeedbackWidget(
        fullScreen: true,
        icon: Icons.person_off_outlined,
        message: l10n.errorSpeakersNone,
      ),
    );
  }

  Widget _buildSpeakerCard(
    BuildContext context,
    AppLocalizations l10n,
    SpeakerSummary speaker,
  ) {
    return Semantics(
      button: true,
      label: l10n.speakerCardSemanticLabel(speaker.name, speaker.title),
      child: Padding(
        padding: const EdgeInsets.only(bottom: UiConstants.spacing16),
        child: SpeakerCard(
          speaker: speaker,
          onTap: () => _handleSpeakerTap(context, speaker),
        ),
      ),
    );
  }

  Widget _buildSpeakersList(
    AppLocalizations l10n,
    List<SpeakerSummary> speakers,
    EdgeInsets padding,
  ) {
    final topPadding = padding.top + kToolbarHeight + UiConstants.spacing16;

    return Semantics(
      container: true,
      label: l10n.speakersTabLabel,
      explicitChildNodes: true,
      child: CustomScrollView(
        key: _speakersListKey,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              UiConstants.spacing16,
              topPadding,
              UiConstants.spacing16,
              padding.bottom,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: speakers.length,
                (context, index) {
                  final speaker = speakers[index];

                  return _buildSpeakerCard(context, l10n, speaker);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @visibleForTesting
  Widget buildBodyContent(
    BuildContext context, {
    required bool isLoading,
    required String? errorMessage,
    required List<SpeakerSummary> speakers,
    required AppLocalizations l10n,
    required EdgeInsets padding,
  }) {
    return switch ((isLoading, errorMessage, speakers.isEmpty)) {
      (true, _, _) => _buildLoadingState(l10n, padding),
      (false, final String msg, _) => _buildErrorState(
        context,
        l10n,
        msg,
        padding,
      ),
      (false, null, true) => _buildEmptyState(l10n),
      _ => _buildSpeakersList(l10n, speakers, padding),
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final padding = context.padding;

    final isLoading = context.select<SpeakersCubit, bool>(_isLoadingSelector);
    final errorMessage = context.select<SpeakersCubit, String?>(
      _errorMessageSelector,
    );
    final speakers = context.select<SpeakersCubit, List<SpeakerSummary>>(
      _speakersSelector,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: FrostedAppBar(title: Text(l10n.speakersTabLabel)),
      body: RefreshIndicator(
        edgeOffset: padding.top + kToolbarHeight,
        onRefresh: () => _handleRefreshIndicatorPull(context),
        child: buildBodyContent(
          context,
          isLoading: isLoading,
          errorMessage: errorMessage,
          speakers: speakers,
          l10n: l10n,
          padding: padding,
        ),
      ),
    );
  }
}
