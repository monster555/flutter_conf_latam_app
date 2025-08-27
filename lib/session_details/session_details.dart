import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';

class SessionDetailsPage extends StatelessWidget {
  const SessionDetailsPage(this.session, {super.key});

  final Session session;

  Widget _buildSessionHeader(
    AppLocalizations l10n,
    TextTheme textTheme,
    String formattedTime,
  ) {
    return Semantics(
      header: true,
      child: Text(
        session.title,
        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMainSpeakerSection(
    SessionSpeaker mainSpeaker,
    String formattedTime,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: UiConstants.spacing16),
        SessionSpeakerInfoCard(
          speaker: mainSpeaker,
          sessionTime: formattedTime,
          track: session.track.toString(),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(TextTheme textTheme, String title) {
    return Semantics(
      header: true,
      child: Text(
        title,
        style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDescriptionSection(
    AppLocalizations l10n,
    TextTheme textTheme,
    String description,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: UiConstants.spacing16),
        _buildSectionTitle(textTheme, l10n.sessionDescriptionLabel),
        const SizedBox(height: UiConstants.spacing8),
        Semantics(
          readOnly: true,
          child: Text(description, style: textTheme.bodyMedium),
        ),
      ],
    );
  }

  Widget _buildAdditionalSpeakersSection(
    AppLocalizations l10n,
    TextTheme textTheme,
    Iterable<SessionSpeaker> additionalSpeakers,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: UiConstants.spacing24),
        _buildSectionTitle(textTheme, l10n.coSpeakersLabel),
        const SizedBox(height: UiConstants.spacing12),
        ...additionalSpeakers.map(
          (speaker) => Padding(
            padding: const EdgeInsets.only(bottom: UiConstants.spacing8),
            child: Semantics(
              button: true,
              label: l10n.speakerCardSemanticLabel(speaker.name, speaker.title),
              child: SessionSpeakerCard(speaker: speaker, label: speaker.title),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptySessionState(AppLocalizations l10n) {
    return Semantics(
      label: l10n.sessionNoDataAvailable,
      child: FeedbackWidget(
        fullScreen: true,
        icon: Icons.event_busy_outlined,
        message: l10n.sessionNoDataAvailable,
      ),
    );
  }

  Widget _buildSessionContent(
    AppLocalizations l10n,
    TextTheme textTheme,
    EdgeInsets padding,
    String formattedTime,
  ) {
    final speakers = session.speakers ?? const <SessionSpeaker>[];

    if (speakers.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top: padding.top + kToolbarHeight),
          child: _buildEmptySessionState(l10n),
        ),
      );
    }

    final mainSpeaker = speakers.first;
    final additionalSpeakers = speakers.skip(1);
    final hasDescription = session.description?.isNotEmpty ?? false;
    final hasAdditionalSpeakers = additionalSpeakers.isNotEmpty;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(UiConstants.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSessionHeader(l10n, textTheme, formattedTime),
            _buildMainSpeakerSection(mainSpeaker, formattedTime),
            if (hasDescription)
              _buildDescriptionSection(l10n, textTheme, session.description!),
            if (hasAdditionalSpeakers)
              _buildAdditionalSpeakersSection(
                l10n,
                textTheme,
                additionalSpeakers,
              ),
          ],
        ),
      ),
    );
  }

  @visibleForTesting
  Widget buildBodyContent(
    AppLocalizations l10n,
    TextTheme textTheme,
    EdgeInsets padding,
    String formattedTime,
  ) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: padding.top + kToolbarHeight),
        ),
        _buildSessionContent(l10n, textTheme, padding, formattedTime),
        SliverToBoxAdapter(child: SizedBox(height: padding.bottom)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = context.textTheme;
    final padding = context.padding;
    final formatter = DateFormatService.withContext(context);
    final formattedDateTimeRange = formatter.formatDateWithTimeRange(
      session.startDate,
      session.endDate,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const FrostedAppBar(),
      body: Semantics(
        label: l10n.sessionDetailsSemanticLabel(session.title),
        container: true,
        explicitChildNodes: true,
        child: buildBodyContent(
          l10n,
          textTheme,
          padding,
          formattedDateTimeRange,
        ),
      ),
    );
  }
}
