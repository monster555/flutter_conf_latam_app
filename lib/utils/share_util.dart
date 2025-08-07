// share_util.dart
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

/// Utility for sharing content (text, files, images) from the app.
class ShareUtil {
  const ShareUtil();

  /// Shares plain text (optionally with a subject).
  Future<bool> shareText(
    String text, {
    String? subject,
    File? previewThumbnail,
  }) {
    return _shareInternal(
      text: text,
      subject: subject,
      previewThumbnail: switch (previewThumbnail) {
        final File file => XFile(file.path),
        null => null,
      },
    );
  }

  /// Shares a single file (e.g., an image) with optional text/subject.
  Future<bool> shareFile(File file, {String? text, String? subject}) {
    final x = XFile(file.path);
    return _shareInternal(
      text: text,
      subject: subject,
      files: [x],
      previewThumbnail: x,
    );
  }

  /// Shares multiple files at once. Uses the first file as preview thumbnail.
  Future<bool> shareFiles(List<File> files, {String? text, String? subject}) {
    if (files.isEmpty) return Future.value(false);
    final xfiles = files.map((f) => XFile(f.path)).toList();
    return _shareInternal(
      text: text,
      subject: subject,
      files: xfiles,
      previewThumbnail: xfiles.first,
    );
  }

  // ---------------------------------------------------------------------------
  // Internals
  // ---------------------------------------------------------------------------

  static Future<bool> _shareInternal({
    String? text,
    String? subject,
    List<XFile>? files,
    XFile? previewThumbnail,
  }) async {
    try {
      final result = await SharePlus.instance.share(
        ShareParams(
          text: text,
          subject: subject,
          files: files,
          previewThumbnail: previewThumbnail,
        ),
      );
      return _isSuccess(result);
    } on PlatformException {
      return false;
    } on FileSystemException {
      return false;
    } on Exception {
      return false;
    }
  }

  static bool _isSuccess(ShareResult result) {
    return result.status == ShareResultStatus.success;
  }
}
