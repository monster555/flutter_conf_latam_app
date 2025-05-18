import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';

typedef FCLSnackbarData =
    ({Color backgroundColor, IconData icon, Color iconColor});

enum FCLSnackbarType {
  success,
  warning,
  error;

  FCLSnackbarData data(BuildContext context) {
    return switch (this) {
      FCLSnackbarType.warning => (
        backgroundColor: context.colorScheme.primary,
        icon: Icons.cancel,
        iconColor: Colors.red,
      ),
      // TODO: Handle this case.
      FCLSnackbarType.success => throw UnimplementedError(),
      // TODO: Handle this case.
      FCLSnackbarType.error => throw UnimplementedError(),
    };
  }
}

class FCLSnackbar extends StatelessWidget {
  const FCLSnackbar._({
    required this.type,
    required this.title,
    required this.description,
    required this.close,
    required this.alignment,
  });

  final FCLSnackbarType type;
  final String title;
  final String description;
  final VoidCallback close;
  final AlignmentGeometry alignment;

  static void show(
    BuildContext context, {
    required FCLSnackbarType type,
    required String title,
    required String description,
    Duration duration = const Duration(seconds: 3),
    AlignmentGeometry alignment = Alignment.topCenter,
  }) {
    final overlay = Overlay.of(context);
    OverlayEntry? entry;
    entry = OverlayEntry(
      builder: (_) {
        return FCLSnackbar._(
          type: type,
          title: title,
          description: description,
          alignment: alignment,
          close: () {
            entry?.remove();
            entry = null;
          },
        );
      },
    );
    overlay.insert(entry!);
    Future.delayed(duration, () {
      entry?.remove();
      entry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = type.data(context);
    final titleStyle = context.textTheme.bodyLarge?.copyWith(
      color: data.iconColor,
      letterSpacing: 0,
      height: 1,
      fontWeight: FontWeight.w600,
    );
    final descriptionStyle = context.primaryButton;
    const spacing12 = SizedBox(width: UiConstants.spacing12);
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Align(
          alignment: alignment,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: data.backgroundColor,
                borderRadius: UiConstants.borderRadiusMedium,
              ),

              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(data.icon, color: data.iconColor),
                    spacing12,
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: titleStyle),
                          const SizedBox(height: UiConstants.spacing4),
                          Text(description, style: descriptionStyle),
                        ],
                      ),
                    ),
                    spacing12,
                    InkWell(
                      onTap: close,
                      child: Icon(Icons.close, color: descriptionStyle?.color),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
