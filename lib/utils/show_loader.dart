import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/router/router.dart';
import 'package:go_router/go_router.dart';

Future<T> showLoader<T>(
  BuildContext context,
  Future<T> future, {
  String? route,
  String? routeParam,
  String? text,
}) async {
  unawaited(
    context.pushNamed(
      route ?? FCLRoutes.loading.name,
      pathParameters: {if (routeParam != null) 'route': routeParam},
    ),
  );
  final result = await future;
  if (context.mounted) {
    context.pop();
  }
  return result;
}
