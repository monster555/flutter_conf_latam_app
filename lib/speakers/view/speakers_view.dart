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

  static bool isLoadingSelector(SpeakersCubit cubit) =>
      cubit.state is SpeakersLoading;

  static String? errorMessageSelector(SpeakersCubit cubit) {
    final state = cubit.state;
    if (state case SpeakersError(:final message)) return message;
    return null;
  }

  static List<SpeakerSummary> speakersSelector(SpeakersCubit cubit) {
    final state = cubit.state;
    if (state case SpeakersLoaded(:final speakers)) return speakers;
    return const <SpeakerSummary>[];
  }

  static bool hasFilterableContentSelector(SpeakersCubit cubit) {
    final state = cubit.state;

    return state is SpeakersLoaded && state.speakers.isNotEmpty;
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
              const SizedBox(height: UiConstants.spacing16),
              ElevatedButton(
                key: const Key('speakers_retry_button'),
                onPressed: () {
                  final languageCode = context.languageCode;
                  context.read<SpeakersCubit>().fetchSpeakers(
                    languageCode: languageCode,
                  );
                },
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

  Widget _buildSpeakerCard(BuildContext context, SpeakerSummary speaker) {
    return Padding(
      padding: const EdgeInsets.only(bottom: UiConstants.spacing16),
      child: SpeakerCard(
        speaker: speaker,
        onTap: () => context.push<void>(SpeakerDetailsPage(speaker)),
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
        key: const PageStorageKey<String>('speakers_list'),
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

                  return _buildSpeakerCard(context, speaker);
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
      (false, final String msg, _) => _buildErrorState(context, msg, padding),
      (false, null, true) => _buildEmptyState(l10n),
      _ => _buildSpeakersList(l10n, speakers, padding),
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final padding = context.padding;

    final isLoading = context.select<SpeakersCubit, bool>(isLoadingSelector);
    final errorMessage = context.select<SpeakersCubit, String?>(
      errorMessageSelector,
    );
    final speakers = context.select<SpeakersCubit, List<SpeakerSummary>>(
      speakersSelector,
    );
    final hasFilterableContent = context.select<SpeakersCubit, bool>(
      hasFilterableContentSelector,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: FrostedAppBar(
        title: Text(l10n.speakersTabLabel),
        actions: [
          if (hasFilterableContent)
            IconButton(
              icon: const Icon(Icons.filter_list_outlined),
              tooltip: l10n.filterSpeakersTooltip,
              onPressed: () {},
            ),
        ],
      ),
      body: buildBodyContent(
        context,
        isLoading: isLoading,
        errorMessage: errorMessage,
        speakers: speakers,
        l10n: l10n,
        padding: padding,
      ),
    );
  }
}
