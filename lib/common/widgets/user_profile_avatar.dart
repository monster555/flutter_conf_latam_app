import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/common/cubits/session/session_cubit.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';

class UserProfileAvatar extends StatelessWidget {
  const UserProfileAvatar({super.key, this.size = 120});
  final double size;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return UserAvatar(
          semanticsLabel: l10n.userAvatarLabel,
          imageUrl: state.user?.avatar,
          userId: state.user?.id,
          size: size,
        );
      },
    );
  }
}
