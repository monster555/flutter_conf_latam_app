import 'package:flutter/material.dart';

extension NavigatorX on BuildContext {
  NavigatorState get _navigator => Navigator.of(this);

  Future<T?> pushX<T>(Widget page) => _navigator.push(
    MaterialPageRoute<T>(builder: (BuildContext context) => page),
  );
}
