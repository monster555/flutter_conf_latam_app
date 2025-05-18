/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsBrandGen {
  const $AssetsBrandGen();

  /// File path: assets/brand/dash_sad.svg
  SvgGenImage get dashSad => const SvgGenImage('assets/brand/dash_sad.svg');

  /// File path: assets/brand/fcl_dark.svg
  SvgGenImage get fclDark => const SvgGenImage('assets/brand/fcl_dark.svg');

  /// File path: assets/brand/fcl_light.svg
  SvgGenImage get fclLight => const SvgGenImage('assets/brand/fcl_light.svg');

  /// List of all assets
  List<SvgGenImage> get values => [dashSad, fclDark, fclLight];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/face.svg
  SvgGenImage get face => const SvgGenImage('assets/icons/face.svg');

  /// File path: assets/icons/flutter_conf_logo_dark.svg
  SvgGenImage get flutterConfLogoDark =>
      const SvgGenImage('assets/icons/flutter_conf_logo_dark.svg');

  /// File path: assets/icons/flutter_conf_logo_light.svg
  SvgGenImage get flutterConfLogoLight =>
      const SvgGenImage('assets/icons/flutter_conf_logo_light.svg');

  /// List of all assets
  List<SvgGenImage> get values =>
      [face, flutterConfLogoDark, flutterConfLogoLight];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/waving_dash.svg
  SvgGenImage get wavingDash =>
      const SvgGenImage('assets/images/waving_dash.svg');

  /// List of all assets
  List<SvgGenImage> get values => [wavingDash];
}

class $AssetsSocialIconsGen {
  const $AssetsSocialIconsGen();

  /// File path: assets/social_icons/apple.svg
  SvgGenImage get apple => const SvgGenImage('assets/social_icons/apple.svg');

  /// File path: assets/social_icons/google.svg
  SvgGenImage get google => const SvgGenImage('assets/social_icons/google.svg');

  /// File path: assets/social_icons/instagram.svg
  SvgGenImage get instagram =>
      const SvgGenImage('assets/social_icons/instagram.svg');

  /// File path: assets/social_icons/linkedin.svg
  SvgGenImage get linkedin =>
      const SvgGenImage('assets/social_icons/linkedin.svg');

  /// File path: assets/social_icons/other.svg
  SvgGenImage get other => const SvgGenImage('assets/social_icons/other.svg');

  /// File path: assets/social_icons/tiktok.svg
  SvgGenImage get tiktok => const SvgGenImage('assets/social_icons/tiktok.svg');

  /// File path: assets/social_icons/x.svg
  SvgGenImage get x => const SvgGenImage('assets/social_icons/x.svg');

  /// File path: assets/social_icons/youtube.svg
  SvgGenImage get youtube =>
      const SvgGenImage('assets/social_icons/youtube.svg');

  /// List of all assets
  List<SvgGenImage> get values =>
      [apple, google, instagram, linkedin, other, tiktok, x, youtube];
}

class Assets {
  Assets._();

  static const String package = 'conf_ui_kit';

  static const $AssetsBrandGen brand = $AssetsBrandGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSocialIconsGen socialIcons = $AssetsSocialIconsGen();
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  static const String package = 'conf_ui_kit';

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => 'packages/conf_ui_kit/$_assetName';
}
