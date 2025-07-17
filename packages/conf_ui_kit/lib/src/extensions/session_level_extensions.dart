import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:flutter/material.dart';

extension SessionLevelX on SessionLevel {
  Color get color => switch (this) {
    SessionLevel.basic => Colors.green,
    SessionLevel.intermediate => Colors.orange,
    SessionLevel.advanced => Colors.red,
    _ => Colors.purple,
  };

  // New defaultText property
  String get defaultText => switch (this) {
    SessionLevel.basic => 'Basic',
    SessionLevel.intermediate => 'Intermediate',
    SessionLevel.advanced => 'Advanced',
    _ => 'Expert',
  };
}
