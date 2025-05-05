import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/src/list_items/social_network_list_item.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

class SocialLinksList extends StatelessWidget {
  const SocialLinksList({
    required this.links,
    required this.onLinkTap,
    this.title,
    super.key,
  });

  final List<SocialMediaLink> links;
  final String? title;
  final void Function(SocialMediaLink) onLinkTap;

  @override
  Widget build(BuildContext context) {
    if (links.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: UiConstants.spacing8),
            child: Text(
              title!,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ...links.map(
          (social) => SocialNetworkListItem(
            social: social,
            onTap: () => onLinkTap(social),
          ),
        ),
      ],
    );
  }
}
