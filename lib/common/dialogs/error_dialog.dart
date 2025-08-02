import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/router/router.dart';
import 'package:go_router/go_router.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog._({super.key});

  static Page<T?> builder<T>(BuildContext _, GoRouterState state) {
    return DialogPage(builder: (_) => ErrorDialog._(key: state.pageKey));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('ErrorDialog Screen')));
  }
}
