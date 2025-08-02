import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/app/localizations_manager.dart';

class App extends StatefulWidget {
  const App({required this.child, super.key});
  final Widget child;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    LocalizationsManager.updateWithContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
