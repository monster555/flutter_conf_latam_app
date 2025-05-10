import 'dart:async';

import 'package:conf_shared_models/conf_shared_models.dart'
    show SocialMediaLink, Speaker, SpeakerX;
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/extensions/language_extensions.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/speaker_details/cubit/speaker_details_cubit.dart';
import 'package:flutter_conf_latam/utils/external_link.dart';

class SpeakerDetailsView extends StatelessWidget {
  const SpeakerDetailsView(this.speaker, {super.key});

  final Speaker speaker;

  static bool isLoadingSelector(SpeakerDetailsCubit cubit) =>
      cubit.state is SpeakerDetailsLoading;

  static String? errorMessageSelector(SpeakerDetailsCubit cubit) {
    final state = cubit.state;
    if (state case SpeakerDetailsError(:final message)) return message;
    return null;
  }

  FutureOr<void> _onSpeakerLinkTap(SocialMediaLink social) async {
    final canLaunch = await ExternalLinkUtil.canLaunchUrl(social.link);
    if (canLaunch) {
      await ExternalLinkUtil.launchUrl(social.link);
    }
  }

  Widget _buildDetailsContent(BuildContext context, Speaker speaker) {
    final l10n = context.l10n;
    final textTheme = context.textTheme;
    final padding = context.padding;
    final topContentOffset = padding.top + kToolbarHeight;
    final languagesText = speaker.languages.formatList(context);

    return Semantics(
      label: speaker.name,
      container: true,
      explicitChildNodes: true,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: topContentOffset)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(UiConstants.spacing16),
              child: Row(
                children: [
                  SpeakerAvatar(
                    speaker: speaker,
                    size: UiConstants.avatarSizeXLarge,
                    showFlag: false,
                  ),
                  const ExcludeSemantics(
                    child: SizedBox(width: UiConstants.spacing16),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          speaker.name,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(speaker.title),

                        MergeSemantics(
                          child: Row(
                            children: [
                              Semantics(
                                label: l10n.countryFlag(speaker.country),
                                child: Text(
                                  speaker.flagEmoji,
                                  style: const TextStyle(
                                    fontSize: UiConstants.fontSizeXLarge,
                                  ),
                                ),
                              ),
                              const ExcludeSemantics(
                                child: SizedBox(width: UiConstants.spacing4),
                              ),
                              Text(speaker.country),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(UiConstants.spacing16),
              child: Text(speaker.description),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(UiConstants.spacing16),
              child: SpeakerLanguagesCard(
                promptText: l10n.dontBeShyLabel,
                languagesPrefix: l10n.iSpeakPrefix,
                languagesList: languagesText,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UiConstants.spacing16,
              ),
              child: SocialLinksList(
                links: speaker.socialMediaLinks,
                title: l10n.contactSectionTitle,
                onLinkTap: _onSpeakerLinkTap,
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: padding.bottom)),
        ],
      ),
    );
  }

  Widget _buildErrorOverlay(BuildContext context, String errorMessage) {
    return Positioned.fill(
      child: ColoredBox(
        color: Colors.black54,
        child: Semantics(
          liveRegion: true,
          label: errorMessage,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(UiConstants.spacing16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(errorMessage),
                  const SizedBox(height: UiConstants.spacing16),
                  ElevatedButton(
                    onPressed:
                        context.read<SpeakerDetailsCubit>().fetchSpeakerDetails,
                    child: Text(context.l10n.actionRetry),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return const Positioned.fill(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<SpeakerDetailsCubit, bool>(
      isLoadingSelector,
    );
    final errorMessage = context.select<SpeakerDetailsCubit, String?>(
      errorMessageSelector,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const FrostedAppBar(),
      body: Stack(
        children: [
          _buildDetailsContent(context, speaker),

          if (errorMessage != null) _buildErrorOverlay(context, errorMessage),

          if (isLoading) _buildLoadingOverlay(),
        ],
      ),
    );
  }
}
