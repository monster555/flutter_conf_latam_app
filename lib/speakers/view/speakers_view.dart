import 'package:conf_shared_models/conf_shared_models.dart' show Speaker;
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

  static List<Speaker> speakersSelector(SpeakersCubit cubit) {
    final state = cubit.state;
    if (state case SpeakersLoaded(:final speakers)) return speakers;
    return const <Speaker>[];
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
              const ExcludeSemantics(
                child: SizedBox(height: UiConstants.spacing16),
              ),
              ElevatedButton(
                onPressed: context.read<SpeakersCubit>().fetchSpeakers,
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

  Widget _buildSpeakerCard(BuildContext context, Speaker speaker) {
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
    List<Speaker> speakers,
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

  Widget _buildContent(BuildContext context) {
    final l10n = context.l10n;
    final padding = context.padding;

    final isLoading = context.select<SpeakersCubit, bool>(isLoadingSelector);
    if (isLoading) return _buildLoadingState(l10n, padding);

    final errorMessage = context.select<SpeakersCubit, String?>(
      errorMessageSelector,
    );
    if (errorMessage != null) {
      return _buildErrorState(context, errorMessage, padding);
    }

    final speakers = context.select<SpeakersCubit, List<Speaker>>(
      speakersSelector,
    );

    if (speakers.isEmpty) return _buildEmptyState(l10n);

    return _buildSpeakersList(l10n, speakers, padding);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
      body: _buildContent(context),
    );
  }
}
