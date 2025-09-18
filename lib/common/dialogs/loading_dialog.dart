import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/router/router.dart';
import 'package:go_router/go_router.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog._({super.key});

  static Page<T?> builder<T>(BuildContext _, GoRouterState state) {
    return DialogPage(
      builder: (_) => LoadingDialog._(key: state.pageKey),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const FCLBlurryLoader();
  }
}
