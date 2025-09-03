import 'dart:async';

import 'package:conf_core/conf_core.dart';
import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/speaker_details/cubit/speaker_details_cubit.dart';
import 'package:flutter_conf_latam/speaker_details/widgets/widgets.dart';
import 'package:flutter_conf_latam/utils/external_link.dart';

class SpeakerDetailsView extends StatelessWidget {
  const SpeakerDetailsView({super.key});

  static const double _loadingIndicatorSize = 32;

  /// Extracts the [SpeakerSummary] from any [SpeakerDetailsState].
  /// This is available in all state variations and provides basic speaker
  /// information.
  static SpeakerSummary _speakerSummarySelector(SpeakerDetailsCubit cubit) =>
      cubit.state.speakerSummary;

  /// Extracts the full [Speaker] details from the cubit state.
  ///
  /// Returns the complete speaker information when available
  /// (in [SpeakerDetailsLoaded] state), otherwise returns null during loading,
  /// error, or initial states.
  /// This allows for progressive UI rendering based on data availability.
  static Speaker? _speakerDetailsSelector(SpeakerDetailsCubit cubit) {
    final state = cubit.state;
    if (state case SpeakerDetailsLoaded(speakerDetails: final speakerDetails)) {
      return speakerDetails;
    }
    return null;
  }

  /// Extracts any error message from the cubit state.
  ///
  /// Returns a non-null error message string only when in the
  /// [SpeakerDetailsError] state, otherwise returns null. Used to conditionally
  /// display error UI.
  static String? _errorMessageSelector(SpeakerDetailsCubit cubit) {
    final state = cubit.state;
    if (state case SpeakerDetailsError(:final errorMessage)) {
      return errorMessage;
    }
    return null;
  }

  /// Determines if the speaker details are currently loading.
  ///
  /// Returns true only when the cubit is in the [SpeakerDetailsLoading] state.
  /// Used to display loading indicators and prevent premature interactions.
  static bool _isLoadingSelector(SpeakerDetailsCubit cubit) =>
      cubit.state is SpeakerDetailsLoading;

  Widget _buildLoadingIndicator() {
    return const SliverToBoxAdapter(
      child: Center(
        child: SizedBox.square(
          dimension: _loadingIndicatorSize,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  FutureOr<void> _onSpeakerLinkTap(
    BuildContext context,
    SocialMediaLink social,
  ) async {
    final l10n = context.l10n;
    try {
      final canLaunch = await ExternalLinkUtil.canLaunchUrl(social.link);
      if (canLaunch) {
        final success = await ExternalLinkUtil.launchUrl(social.link);
        if (!success && context.mounted) {
          _showErrorSnackBar(context, l10n.errorCannotOpenLink);
        }
      } else {
        if (context.mounted) {
          _showErrorSnackBar(context, l10n.errorCannotOpenLink);
        }
      }
    } on Exception catch (_) {
      if (context.mounted) {
        _showErrorSnackBar(context, l10n.errorGeneric);
      }
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
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
                    key: const Key('speaker_details_retry_button'),
                    onPressed: () {
                      final languageCode = context.languageCode;
                      context.read<SpeakerDetailsCubit>().fetchSpeakerDetails(
                        languageCode: languageCode,
                      );
                    },
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

  Widget _buildProgressiveContent(
    BuildContext context,
    SpeakerSummary speakerSummary,
    Speaker? speakerDetails,
    double topContentOffset,
    double bottomPadding,
    bool isLoading,
  ) {
    return Semantics(
      label: speakerSummary.name,
      container: true,
      explicitChildNodes: true,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: topContentOffset)),
          SpeakerDetailsHeaderSection(
            key: const Key('speaker_details_header'),
            speakerSummary: speakerSummary,
          ),
          SpeakerDetailsDescriptionSection(
            key: const Key('speaker_details_description'),
            speakerDetails: speakerDetails,
          ),
          SpeakerDetailsLanguagesSection(
            key: const Key('speaker_details_languages'),
            speakerSummary: speakerSummary,
          ),
          SpeakerDetailsSocialLinksSection(
            key: const Key('speaker_details_social_links'),
            speakerDetails: speakerDetails,
            onLinkTap: (social) => _onSpeakerLinkTap(context, social),
          ),
          if (isLoading) _buildLoadingIndicator(),
          SliverToBoxAdapter(
            child: SizedBox(height: bottomPadding + UiConstants.spacing16),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = context.padding;
    final topContentOffset = padding.top + kToolbarHeight;

    final speakerSummary = context.select<SpeakerDetailsCubit, SpeakerSummary>(
      _speakerSummarySelector,
    );

    final speakerDetails = context.select<SpeakerDetailsCubit, Speaker?>(
      _speakerDetailsSelector,
    );

    final errorMessage = context.select<SpeakerDetailsCubit, String?>(
      _errorMessageSelector,
    );

    final isLoading = context.select<SpeakerDetailsCubit, bool>(
      _isLoadingSelector,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const FrostedAppBar(),
      body: Stack(
        children: [
          _buildProgressiveContent(
            context,
            speakerSummary,
            speakerDetails,
            topContentOffset,
            padding.bottom,
            isLoading,
          ),

          if (errorMessage != null) _buildErrorOverlay(context, errorMessage),
        ],
      ),
    );
  }
}
