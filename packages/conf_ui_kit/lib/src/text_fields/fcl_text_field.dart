import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';

class FCLTextField extends StatelessWidget {
  const FCLTextField({
    required this.label,
    super.key,
    this.hint,
    this.controller,
    this.prefixIcon,
    this.keyboardType,
    this.onChanged,
  });
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: context.textTheme.bodyMedium,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: context.textTheme.bodySmall,
        hintText: hint,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
