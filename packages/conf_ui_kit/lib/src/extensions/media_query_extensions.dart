import 'package:flutter/widgets.dart';

extension MediaQueryX on BuildContext {
  // Get the context padding
  EdgeInsets get padding => MediaQuery.paddingOf(this);
}
