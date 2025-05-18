import 'dart:async';

import 'package:conf_shared_models/conf_shared_models.dart'
    show SocialMediaLink, Speaker;
import 'package:conf_ui_kit/conf_ui_kit.dart' show SocialLinksList, UiConstants;
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';

class SpeakerDetailsSocialLinksSection extends StatelessWidget {
  const SpeakerDetailsSocialLinksSection({
    required this.onLinkTap,
    super.key,
    this.speakerDetails,
  });

  final Speaker? speakerDetails;
  final FutureOr<void> Function(SocialMediaLink social) onLinkTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final socialMediaLinks = speakerDetails?.socialMediaLinks;
    if (socialMediaLinks == null || socialMediaLinks.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: UiConstants.spacing16),
        child: SocialLinksList(
          links: socialMediaLinks,
          title: l10n.contactSectionTitle,
          onLinkTap: onLinkTap,
        ),
      ),
    );
  }
}
