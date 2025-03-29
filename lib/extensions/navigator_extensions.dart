import 'package:flutter/material.dart';

extension NavigatorX on BuildContext {
  NavigatorState get _navigator => Navigator.of(this);

  Future<T?> push<T>(Widget page) => _navigator.push(
    MaterialPageRoute<T>(builder: (BuildContext context) => page),
  );
}
