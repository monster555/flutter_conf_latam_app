import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

class VenueBanner extends StatelessWidget {
  const VenueBanner({
    required this.venueName,
    required this.location,
    required this.dates,
    required this.imagePath,
    this.title = 'Próxima parada',
    this.onTap,
    super.key,
  });

  final String title;
  final String venueName;
  final String location;
  final String dates;
  final String imagePath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const ExcludeSemantics(child: SizedBox(height: 4)),
        _BannerCard(
          venueName: venueName,
          location: location,
          dates: dates,
          imagePath: imagePath,
          onTap: onTap,
        ),
      ],
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({
    required this.venueName,
    required this.location,
    required this.dates,
    required this.imagePath,
    this.onTap,
  });

  static const _topGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromRGBO(0, 0, 0, 0.7), Colors.transparent],
  );

  static const _bottomGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      Color.fromRGBO(0, 0, 0, 0.5),
      Color.fromRGBO(0, 0, 0, 0.7),
    ],
  );

  static const _baseColor = Colors.white;

  final String venueName;
  final String location;
  final String dates;
  final String imagePath;
  final VoidCallback? onTap;

  Widget _buildOverlay({
    required Alignment alignment,
    required double heightFactor,
    required Gradient gradient,
    required Widget child,
  }) {
    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: FractionallySizedBox(
          heightFactor: heightFactor,
          widthFactor: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(gradient: gradient),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildTopContent(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        UiConstants.spacing16,
        UiConstants.spacing12,
        UiConstants.spacing16,
        0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              venueName,
              style: textTheme.bodyMedium?.copyWith(
                color: _baseColor,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomContent(TextTheme textTheme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        UiConstants.spacing16,
        0,
        UiConstants.spacing16,
        UiConstants.spacing12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  location,
                  style: textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _baseColor,
                  ),
                ),
                Text(
                  dates,
                  style: textTheme.bodyLarge?.copyWith(color: _baseColor),
                ),
              ],
            ),
          ),
          SizedBox.square(
            dimension: UiConstants.iconSizeXLarge,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary.withValues(alpha: 0.6),
              ),
              child: const Icon(Icons.navigate_next, color: _baseColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return Image.network(imageUrl, fit: BoxFit.cover, width: double.infinity);
    } else {
      return Image.asset(imageUrl, fit: BoxFit.cover, width: double.infinity);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    final semanticLabel =
        'Venue: $venueName. Location: $location. Dates: $dates';

    return Semantics(
      label: semanticLabel,
      button: onTap != null,
      child: ClipRRect(
        borderRadius: UiConstants.borderRadiusLarge,
        child: Stack(
          children: [
            ExcludeSemantics(child: _buildImage(imagePath)),
            _buildOverlay(
              alignment: Alignment.topCenter,
              heightFactor: 0.25,
              gradient: _topGradient,
              child: ExcludeSemantics(child: _buildTopContent(textTheme)),
            ),
            _buildOverlay(
              alignment: Alignment.bottomCenter,
              heightFactor: 0.4,
              gradient: _bottomGradient,
              child: ExcludeSemantics(
                child: _buildBottomContent(textTheme, colorScheme),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  splashColor: context.colorScheme.primary.withValues(
                    alpha: 0.2,
                  ),
                  highlightColor: context.colorScheme.primary.withValues(
                    alpha: 0.1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
