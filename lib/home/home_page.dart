import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/agenda/agenda_page.dart';
import 'package:flutter_conf_latam/common/common.dart';
import 'package:flutter_conf_latam/extensions/navigator_extensions.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/speakers/speakers_page.dart';
import 'package:flutter_conf_latam/sponsors/sponsors_page.dart';
import 'package:flutter_conf_latam/venue/venue_page.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage._({super.key});

  static Widget builder(BuildContext _, GoRouterState state) {
    return HomePage._(key: state.pageKey);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final padding = context.padding;

    const venueName = 'Universidad de las Américas';
    const location = 'Quito, Ecuador';
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
          onProfileTap: context.read<SessionCubit>().logout,
        ),
        body: CustomScrollView(
          slivers: [
            SliverPinnedHeader(
              child: Padding(
                padding: EdgeInsets.only(top: padding.top + kToolbarHeight),
                child: CountdownWidget(
                  title: l10n.magicBeginsLabel,
                  targetDate: DateTime(2025, 9, 9),
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
                  const ExcludeSemantics(
                    child: SizedBox(height: UiConstants.spacing16),
                  ),
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
                    onTap: () => context.pushX<void>(const VenuePage()),
                  ),
                  const ExcludeSemantics(
                    child: SizedBox(height: UiConstants.spacing16),
                  ),
                  SectionNavigationCard(
                    title: l10n.agendaTabLabel,
                    description: l10n.agendaNavigationDescription,
                    icon: Icons.calendar_today,
                    onTap: () => context.pushX<void>(const AgendaPage()),
                  ),
                  SectionNavigationCard(
                    title: l10n.speakersTabLabel,
                    description: l10n.speakersNavigationDescription,
                    icon: Icons.people,
                    onTap: () => context.pushX<void>(const SpeakersPage()),
                  ),
                  SectionNavigationCard(
                    title: l10n.sponsorsTabLabel,
                    description: l10n.sponsorsNavigationDescription,
                    icon: Icons.business,
                    onTap: () => context.pushX<void>(const SponsorsPage()),
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
