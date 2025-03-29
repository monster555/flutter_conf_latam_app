import 'package:conf_ui_kit/src/effects/frosted_glass.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    final effectiveLeading =
        leading ??
        (automaticallyImplyLeading && Navigator.of(context).canPop()
            ? BackButton(color: Theme.of(context).colorScheme.primary)
            : null);

    final effectiveAlignment =
        centerTitle ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween;

    final effectiveTitle =
        title != null ? Semantics(header: true, child: title) : null;

    return FrostedGlass(
      child: Semantics(
        container: true,
        explicitChildNodes: true,
        label: 'App Bar',
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
                    const ExcludeSemantics(
                      child: SizedBox(width: UiConstants.spacing16),
                    ),
                  ],

                  if (title != null)
                    Expanded(
                      child:
                          centerTitle
                              ? Center(child: effectiveTitle)
                              : effectiveTitle!,
                    ),

                  if (actions != null) ...[
                    ...actions!.map(
                      (action) => Padding(
                        padding: const EdgeInsets.only(
                          left: UiConstants.spacing16,
                        ),
                        child: action,
                      ),
                    ),
                  ],
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
