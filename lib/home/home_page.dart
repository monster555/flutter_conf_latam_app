import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/extensions/navigator_extensions.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/mock/mock_data.dart';
import 'package:flutter_conf_latam/session_details/session_details.dart';
import 'package:flutter_conf_latam/speaker_details/speaker_details.dart';

class Homepage extends StatelessWidget {
  const Homepage({required this.onNavigateToVenue, super.key});

  static const _contentPadding = EdgeInsets.fromLTRB(
    UiConstants.spacing16,
    UiConstants.spacing16,
    UiConstants.spacing16,
    0,
  );

  final VoidCallback onNavigateToVenue;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final padding = context.padding;

    final topSectionPadding = EdgeInsets.fromLTRB(
      UiConstants.spacing16,
      padding.top + UiConstants.spacing16,
      UiConstants.spacing16,
      0,
    );

    final bottomSectionPadding = EdgeInsets.fromLTRB(
      UiConstants.spacing16,
      UiConstants.spacing16,
      UiConstants.spacing16,
      padding.bottom + UiConstants.spacing16,
    );

    final sessions = ConferenceMockData.getSessionsList();
    final speakers = ConferenceMockData.getSpeakers();

    const venueName = 'Universidad de las Américas';
    const location = 'Quito, Ecuador';
    final dates = l10n.conferenceDates(9, 10);

    return Semantics(
      container: true,
      label: l10n.homeTabLabel,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: topSectionPadding,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                VenueBanner(
                  title: l10n.venueBannerTitle,
                  imagePath: 'assets/images/udla.webp',
                  venueName: venueName,
                  location: location,
                  dates: dates,
                  semanticLabel: l10n.venueBannerSemanticLabel(
                    venueName,
                    location,
                    dates,
                  ),
                  semanticHint: l10n.venueBannerSemanticsHint,
                  onTap: onNavigateToVenue,
                ),
                const ExcludeSemantics(
                  child: SizedBox(height: UiConstants.spacing16),
                ),
                CountdownWidget(
                  title: l10n.magicBeginsLabel,
                  targetDate: DateTime(2025, 9, 9),
                  daysLabel: l10n.days,
                  hoursLabel: l10n.hours,
                  minutesLabel: l10n.minutes,
                  secondsLabel: l10n.seconds,
                ),
              ]),
            ),
          ),
          SliverPadding(
            padding: _contentPadding,
            sliver: SpeakersSection(
              sectionTitle: l10n.speakersTabLabel,
              speakers: speakers,
              onSpeakerTap:
                  (speaker) => context.push<void>(SpeakerDetailsPage(speaker)),
            ),
          ),
          SliverPadding(
            padding: bottomSectionPadding,
            sliver: AgendaSection(
              sectionTitle: l10n.agendaTabLabel,
              noSessionsMessage: l10n.agendaPreviewEmptyMessage,
              sessions: sessions,
              sessionLevelLabels: {
                SessionLevel.basic: l10n.sessionLevelBasic,
                SessionLevel.intermediate: l10n.sessionLevelIntermediate,
                SessionLevel.advanced: l10n.sessionLevelAdvanced,
                SessionLevel.expert: l10n.sessionLevelExpert,
              },
              onSessionTap:
                  (session) => context.push<void>(SessionDetailsPage(session)),
              hideWhenEmpty: true,
            ),
          ),
        ],
      ),
    );
  }
}
