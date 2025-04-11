import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/extensions/navigator_extensions.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/speaker_details/speaker_details.dart';

class SessionDetailsPage extends StatelessWidget {
  const SessionDetailsPage(this.session, {super.key});

  final Session session;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final padding = context.padding;
    final formatter = DateFormatService.withContext(context);
    final formattedStartTime = formatter.formatDateAndTime(session.startTime);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const FrostedAppBar(),
      body: Semantics(
        label: session.title,
        container: true,
        explicitChildNodes: true,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ExcludeSemantics(
                child: SizedBox(height: padding.top + kToolbarHeight),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(UiConstants.spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.title,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const ExcludeSemantics(
                      child: SizedBox(height: UiConstants.spacing16),
                    ),

                    IconLabel(
                      icon: Icons.access_time,
                      label: formattedStartTime,
                    ),
                    const ExcludeSemantics(
                      child: SizedBox(height: UiConstants.spacing4),
                    ),
                    IconLabel(
                      icon: Icons.timelapse_outlined,
                      label: session.durationText,
                    ),
                    const ExcludeSemantics(
                      child: SizedBox(height: UiConstants.spacing4),
                    ),
                    IconLabel(
                      icon: Icons.location_on_outlined,
                      label: session.track,
                    ),

                    const ExcludeSemantics(
                      child: SizedBox(height: UiConstants.spacing16),
                    ),
                    Text(session.description),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(UiConstants.spacing16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Semantics(
                      header: true,
                      child: Text(
                        context.l10n.speaker,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const ExcludeSemantics(
                      child: SizedBox(height: UiConstants.spacing8),
                    ),
                    SpeakerCard(
                      speaker: session.speaker,
                      showBio: false,
                      cardSize: SpeakerCardSize.small,
                      onTap:
                          () => context.push<void>(
                            SpeakerDetailsPage(session.speaker),
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ExcludeSemantics(child: SizedBox(height: padding.bottom)),
            ),
          ],
        ),
      ),
    );
  }
}
