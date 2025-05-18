import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/app/localizations_manager.dart';
import 'package:flutter_conf_latam/auth/auth.dart';

class App extends StatefulWidget {
  const App({super.key});

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
    return const AuthPage();
    // return const HomePage();
  }
}
