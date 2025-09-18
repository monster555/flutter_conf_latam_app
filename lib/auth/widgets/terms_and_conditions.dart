import 'dart:developer' show log;

import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/common/common.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';

enum TermsAcceptanceStatus { notAccepted, accepted }

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    const gap12 = ExcludeSemantics(
      child: SizedBox(height: UiConstants.spacing12),
    );
    const spacing12 = ExcludeSemantics(
      child: SizedBox(width: UiConstants.spacing12),
    );
    final l10n = context.l10n;
    final state = context.watch<ValueCubit<TermsAcceptanceStatus?>>().state;
    final accepted = state == TermsAcceptanceStatus.accepted;
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          gap12,
          Row(
            children: [
              Semantics(
                label:
                    '${l10n.accept} ${l10n.termsLabel}'
                    '${l10n.termsAndPrivacyAnd}'
                    '${l10n.privacyPolicyLabel}',
                child: AppCheckbox(
                  checked: accepted,
                  onChanged: (value) {
                    context.read<ValueCubit<TermsAcceptanceStatus?>>().update(
                      value.status,
                    );
                  },
                ),
              ),
              spacing12,
              const Expanded(child: _TermsAndConditions()),
            ],
          ),
          gap12,
        ],
      ),
    );
  }
}

extension on bool {
  TermsAcceptanceStatus get status => switch (this) {
    true => TermsAcceptanceStatus.accepted,
    false => TermsAcceptanceStatus.notAccepted,
  };
}

class _TermsAndConditions extends StatelessWidget {
  const _TermsAndConditions();

  Future<void> _openTerms() async {
    log('Terms And conditions');
  }

  Future<void> _openPrivacyPolicy() async {
    log('Privacy policy');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final boldStyle = context.textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w700,
      color: context.colorScheme.secondary,
    );
    return Semantics(
      label:
          '${l10n.termsAndPrivacyPart1}'
          '${l10n.termsLabel}${l10n.termsAndPrivacyAnd}'
          '${l10n.privacyPolicyLabel}${l10n.termsAndPrivacyPart2}',
      child: Text.rich(
        TextSpan(
          text: l10n.termsAndPrivacyPart1,
          style: context.textTheme.bodySmall,
          children: [
            TextSpan(
              text: l10n.termsLabel,
              style: boldStyle,
              recognizer: TapGestureRecognizer()..onTap = _openTerms,
            ),
            TextSpan(text: l10n.termsAndPrivacyAnd),
            TextSpan(
              text: l10n.privacyPolicyLabel,
              style: boldStyle,
              recognizer: TapGestureRecognizer()..onTap = _openPrivacyPolicy,
            ),
            TextSpan(text: l10n.termsAndPrivacyPart2),
          ],
        ),
      ),
    );
  }
}
