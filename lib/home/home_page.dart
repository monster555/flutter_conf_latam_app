import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/agenda/agenda_page.dart';
import 'package:flutter_conf_latam/extensions/navigator_extensions.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/speakers/speakers_page.dart';
import 'package:flutter_conf_latam/sponsors/sponsors_page.dart';
import 'package:flutter_conf_latam/venue/venue_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final _eventStartDate = DateTime(2025, 9, 9);
  static const _venueName = 'Universidad de las Américas';
  static const _location = 'Quito, Ecuador';
  static const _bannerAssetPath = 'assets/images/udla.webp';
  static const _agendaIconPath = 'assets/icons/agenda_icon.png';
  static const _speakersIconPath = 'assets/icons/speakers_icon.png';
  static const _sponsorsIconPath = 'assets/icons/sponsors_icon.png';

  bool get _shouldShowCountdown => DateTime.now().isBefore(_eventStartDate);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final padding = context.padding;

    final dates = l10n.conferenceDates(9, 10);

    return Semantics(
      container: true,
      label: l10n.homeTabLabel,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: MainAppBar(
          profileLabel: l10n.userProfileLabel,
          profileHint: l10n.userProfileHint,
          profileTooltip: l10n.userProfileTooltip,
          onProfileTap: () {},
        ),
        body: CustomScrollView(
          slivers: [
            if (_shouldShowCountdown)
              SliverPinnedHeader(
                child: Padding(
                  padding: EdgeInsets.only(top: padding.top + kToolbarHeight),
                  child: CountdownWidget(
                    title: l10n.magicBeginsLabel,
                    targetDate: _eventStartDate,
                    daysLabel: l10n.days,
                    hoursLabel: l10n.hours,
                    minutesLabel: l10n.minutes,
                    secondsLabel: l10n.seconds,
                  ),
                ),
              ),

            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                UiConstants.spacing16,
                0,
                UiConstants.spacing16,
                padding.bottom,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: UiConstants.spacing16),
                  VenueBanner(
                    title: l10n.venueBannerTitle,
                    imagePath: _bannerAssetPath,
                    venueName: _venueName,
                    location: _location,
                    dates: dates,
                    semanticLabel: l10n.venueBannerSemanticLabel(
                      _venueName,
                      _location,
                      dates,
                    ),
                    semanticHint: l10n.venueBannerSemanticsHint,
                    onTap: () => context.push<void>(const VenuePage()),
                  ),
                  const SizedBox(height: UiConstants.spacing16),
                  SectionNavigationCard(
                    title: l10n.agendaTabLabel,
                    description: l10n.agendaNavigationDescription,
                    assetPath: _agendaIconPath,
                    onTap: () => context.push<void>(const AgendaPage()),
                  ),
                  SectionNavigationCard(
                    title: l10n.speakersTabLabel,
                    description: l10n.speakersNavigationDescription,
                    assetPath: _speakersIconPath,
                    onTap: () => context.push<void>(const SpeakersPage()),
                  ),
                  SectionNavigationCard(
                    title: l10n.sponsorsTabLabel,
                    description: l10n.sponsorsNavigationDescription,
                    assetPath: _sponsorsIconPath,
                    onTap: () => context.push<void>(const SponsorsPage()),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
