import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:flutter/material.dart';

extension SessionLevelX on SessionLevel {
  Color get color => switch (this) {
    SessionLevel.basic => Colors.green.shade700,
    SessionLevel.intermediate => Colors.orange.shade700,
    SessionLevel.advanced => Colors.red.shade700,
    SessionLevel.expert => Colors.purple.shade700,
  };

  // New defaultText property
  String get defaultText => switch (this) {
    SessionLevel.basic => 'Basic',
    SessionLevel.intermediate => 'Intermediate',
    SessionLevel.advanced => 'Advanced',
    _ => 'Expert',
  };
}
