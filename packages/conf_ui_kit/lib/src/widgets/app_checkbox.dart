import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';

class AppCheckbox extends StatefulWidget {
  const AppCheckbox({
    required this.checked,
    required this.onChanged,
    super.key,
  });
  final bool checked;
  final ValueChanged<bool> onChanged;

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  late final checked = ValueNotifier(widget.checked);

  @override
  void dispose() {
    checked.dispose();
    super.dispose();
  }

  void onTap() {
    final value = checked.value;
    checked.value = !value;
    widget.onChanged(!value);
  }

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme.onSurface;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox.square(
        dimension: 20,
        child: ValueListenableBuilder(
          valueListenable: checked,
          builder: (_, value, __) {
            return DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: color, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(2)),
              ),
              child: switch (value) {
                true => const Icon(Icons.check_rounded, size: 16),
                false => null,
              },
            );
          },
        ),
      ),
    );
  }
}
