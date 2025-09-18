// capture_util.dart
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

/// Utility for capturing widgets as images (PNG) without extra packages.
/// Wrap the target widget with a [RepaintBoundary] and pass its [GlobalKey].
///
/// Example:
///   final key = GlobalKey();
///   RepaintBoundary(key: key, child: YourWidget());
///   final bytes = await CaptureUtil.captureWidgetBytes(key);
class CaptureUtil {
  const CaptureUtil();

  /// Captures the widget referenced by [key] as PNG bytes.
  /// Returns `null` if the boundary is not found or on failure.
  Future<Uint8List?> captureWidgetBytes(
    GlobalKey key, {
    double pixelRatio = 3.0,
  }) async {
    try {
      final renderObject = key.currentContext?.findRenderObject();
      if (renderObject is! RenderRepaintBoundary) return null;

      final image = await renderObject.toImage(pixelRatio: pixelRatio);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } on Exception catch (_) {
      return null;
    }
  }

  /// Captures the widget as PNG and saves it into the temporary directory.
  /// Returns the created [File] or `null` if something fails.
  Future<File?> captureWidgetToFile(
    GlobalKey key, {
    String filename = 'capture.png',
    double pixelRatio = 3.0,
  }) async {
    try {
      final bytes = await captureWidgetBytes(key, pixelRatio: pixelRatio);
      if (bytes == null) return null;
      final file = await _saveBytesToTemp(bytes, filename);
      return file;
    } on FileSystemException catch (_) {
      return null;
    } on Exception catch (_) {
      return null;
    }
  }

  /// Saves [bytes] to a temporary file and returns it.
  static Future<File> _saveBytesToTemp(Uint8List bytes, String filename) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
