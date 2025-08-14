import 'package:conf_ui_kit/src/effects/frosted_glass.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

/// A customized app bar with a frosted glass effect.
///
/// Similar to [AppBar] but with a blur effect background and custom styling.
class FrostedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FrostedAppBar({
    this.title,
    this.leading,
    this.actions,
    this.centerTitle = false,
    this.automaticallyImplyLeading = true,
    this.padding = const EdgeInsets.symmetric(
      horizontal: UiConstants.spacing16,
    ),
    this.height = kToolbarHeight,
    super.key,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final EdgeInsetsGeometry padding;
  final double height;

  Widget? _getStyledTitle(BuildContext context) {
    if (title == null) return null;

    if (title is Text) {
      final textTitle = title! as Text;
      final defaultStyle = context.textTheme.titleLarge?.copyWith(
        color: context.colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      );

      if (textTitle.style == null) {
        return Text(
          textTitle.data!,
          style: defaultStyle,
          maxLines: textTitle.maxLines,
          overflow: textTitle.overflow ?? TextOverflow.ellipsis,
          textAlign: textTitle.textAlign,
        );
      }
    }

    return title;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveLeading =
        leading ??
        (automaticallyImplyLeading && Navigator.of(context).canPop()
            ? BackButton(color: context.colorScheme.primary)
            : null);

    final effectiveAlignment =
        centerTitle ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween;

    final effectiveTitle = _getStyledTitle(context);

    return FrostedGlass(
      child: Semantics(
        container: true,
        explicitChildNodes: true,
        label:
            title != null && title is Text
                ? 'App Bar: ${(title! as Text).data}'
                : 'App Bar',
        child: SafeArea(
          bottom: false,
          child: SizedBox(
            height: height,
            child: Padding(
              padding: padding,
              child: Row(
                mainAxisAlignment: effectiveAlignment,
                children: [
                  if (effectiveLeading != null) ...[
                    effectiveLeading,
                    const SizedBox(width: UiConstants.spacing16),
                  ],

                  if (title != null)
                    Expanded(
                      child:
                          centerTitle
                              ? Center(child: effectiveTitle)
                              : effectiveTitle!,
                    ),

                  if (actions != null) Row(children: actions!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
