import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/router/dialog_page.dart';
import 'package:go_router/go_router.dart';

enum ErrorDialogType { generic, internet }

extension on ErrorDialogType {
  String title(BuildContext context) {
    final l10n = context.l10n;
    return switch (this) {
      ErrorDialogType.generic => l10n.authErrorGenericTitle,
      ErrorDialogType.internet => l10n.authErrorInternetTitle,
    };
  }

  String description(BuildContext context) {
    final l10n = context.l10n;
    return switch (this) {
      ErrorDialogType.generic => l10n.authErrorGenericDescription,
      ErrorDialogType.internet => l10n.authErrorInternetDescription,
    };
  }
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog._(this.type);
  final ErrorDialogType type;

  static Page<T?> builder<T>(BuildContext _, GoRouterState state) {
    final extra = state.extra as Map<String, dynamic>?;
    final type = ErrorDialogType.values.firstWhere(
      (type) => type.name == extra?['type'],
      orElse: () => ErrorDialogType.generic,
    );
    return DialogPage(
      barrierDismissible: false,
      builder: (_) => ErrorDialog._(type),
    );
  }

  @override
  Widget build(BuildContext context) {
    const gap16 = ExcludeSemantics(
      child: SizedBox(height: UiConstants.spacing16),
    );
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: UiConstants.spacing40),
        child: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.scaffoldBackgroundColor,
              borderRadius: UiConstants.borderRadiusLarge,
            ),
            child: Padding(
              padding: const EdgeInsets.all(UiConstants.spacing24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ExcludeSemantics(
                    child: Assets.brand.dashSad.image(width: 100),
                  ),
                  gap16,
                  Semantics(
                    label: type.title(context),
                    header: true,
                    child: Text(
                      type.title(context),
                      style: context.textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  gap16,
                  Semantics(
                    label: type.description(context),
                    header: true,
                    child: Text(
                      type.description(context),
                      style: context.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const ExcludeSemantics(
                    child: SizedBox(height: UiConstants.spacing24),
                  ),
                  const _Buttons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Semantics(
            label: l10n.cancelButton,
            header: true,
            child: FCLSecondaryButton(
              text: l10n.cancelButton,
              onPressed: () => context.pop(false),
            ),
          ),
        ),
        Expanded(
          child: Semantics(
            label: l10n.retryButton,
            header: true,
            child: FCLPrimaryButton(
              text: l10n.retryButton,
              onPressed: () => context.pop(true),
            ),
          ),
        ),
      ],
    );
  }
}
