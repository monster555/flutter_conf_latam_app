import 'package:cached_network_image/cached_network_image.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    required this.semanticsLabel,
    this.userId,
    this.size = 120,
    super.key,
    this.imageUrl,
  });
  final String semanticsLabel;
  final double size;
  final String? imageUrl;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    final placeHolder = Center(child: Assets.icons.person.svg());
    return Semantics(
      label: semanticsLabel,
      image: true,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: SizedBox.square(
          dimension: size,
          child: DecoratedBox(
            decoration: const BoxDecoration(color: Color(0XFFD0D5DD)),
            child: switch (imageUrl) {
              final String imageUrl => CachedNetworkImage(
                imageUrl: imageUrl,
                cacheKey: 'user-$userId',
                fit: BoxFit.cover,
                width: size,
                height: size,
                fadeInDuration: UiConstants.animationMedium,
                errorWidget: (_, _, _) => placeHolder,
              ),
              null => placeHolder,
            },
          ),
        ),
      ),
    );
  }
}
