import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Displays a sponsor's logo from a network SVG.
///
/// Provides accessibility labels and handles loading/error states.
class SponsorLogo extends StatelessWidget {
  /// Creates a sponsor logo widget.
  ///
  /// The [imageUrl] and [sponsorName] must not be null.
  const SponsorLogo({
    required this.imageUrl,
    required this.sponsorName,
    this.width,
    this.height = 80,
    this.fit = BoxFit.scaleDown,
    this.padding = const EdgeInsets.all(16),
    super.key,
  });

  final String imageUrl;
  final String sponsorName;
  final double? width;
  final double height;
  final BoxFit fit;
  final EdgeInsets padding;

  Widget _buildPlaceholder(BuildContext context) {
    return const Center(
      child: SizedBox.square(
        dimension: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  Widget _buildImageErrorWidget(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return Icon(
      Icons.business_outlined,
      size: height / 2,
      color: context.colorScheme.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Semantics(
      label: '$sponsorName logo',
      image: true,
      child: ExcludeSemantics(
        child: Padding(
          padding: padding,
          child: SizedBox(
            width: width,
            height: height,
            child: SvgPicture.network(
              imageUrl,
              fit: fit,
              excludeFromSemantics: true,
              colorFilter: ColorFilter.mode(
                colorScheme.primary,
                BlendMode.srcIn,
              ),
              placeholderBuilder: _buildPlaceholder,
              errorBuilder: _buildImageErrorWidget,
            ),
          ),
        ),
      ),
    );
  }
}
