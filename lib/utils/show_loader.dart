import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/router/router.dart';
import 'package:go_router/go_router.dart';

Future<T> showLoader<T>(
  BuildContext context,
  String route,
  Future<T> future, {
  String? text,
}) async {
  unawaited(
    context.pushNamed(FCLRoutes.loading.name, pathParameters: {'route': route}),
  );
  final result = await future;
  if (context.mounted) {
    context.pop();
  }
  return result;
}
