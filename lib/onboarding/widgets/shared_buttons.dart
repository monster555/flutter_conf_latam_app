import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/common/cubits/cubits.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/router/router.dart';
import 'package:flutter_conf_latam/utils/utils.dart';
import 'package:go_router/go_router.dart';

class SharedButtons extends StatelessWidget {
  const SharedButtons({super.key});

  Future<void> _startCaptureAndShared(BuildContext context) async {
    final result = await showLoader(
      context,
      _performCaptureAndShared(context),
      route: FCLRoutes.sharingFclCard.name,
    );
    if (result && context.mounted) {
      context.goNamed(FCLRoutes.home.name);
    }
  }

  Future<bool> _performCaptureAndShared(BuildContext context) async {
    await WidgetsBinding.instance.endOfFrame;
    if (!context.mounted) return false;
    final globalKey = context.read<GlobalKey>();
    final captureUtil = context.read<CaptureUtil>();
    final user = context.read<SessionCubit>().state.user;
    final file = await captureUtil.captureWidgetToFile(
      globalKey,
      filename: user.safeShareFilename(),
    );
    if (file == null || !context.mounted) return false;
    final l10n = context.l10n;
    final text =
        '${l10n.badgeImPartOf} ${l10n.badgeConference} ${l10n.badgeYear}';
    final subject = '${l10n.badgeConference} ${l10n.badgeYear}';
    final shareUtil = context.read<ShareUtil>();
    return shareUtil.shareFile(file, text: text, subject: subject);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Semantics(
            label: l10n.shareLater,
            header: true,
            child: FCLSecondaryButton(
              text: l10n.shareLater,
              onPressed: () => context.goNamed(FCLRoutes.home.name),
            ),
          ),
        ),
        Expanded(
          child: Semantics(
            label: l10n.shareAction,
            header: true,
            child: FCLPrimaryButton(
              text: l10n.shareAction,
              onPressed: () => _startCaptureAndShared(context),
            ),
          ),
        ),
      ],
    );
  }
}
