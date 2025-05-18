import 'package:conf_core/conf_core.dart';
import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/speaker_details/cubit/speaker_details_cubit.dart';
import 'package:flutter_conf_latam/speaker_details/view/speaker_details_view.dart';
import 'package:speakers_repository/speakers_repository.dart';

class SpeakerDetailsPage extends StatelessWidget {
  const SpeakerDetailsPage(this.summary, {super.key});

  final SpeakerSummary summary;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpeakerDetailsCubit>(
      create: (context) {
        final repository = context.read<SpeakersRepository>();
        final cubit = SpeakerDetailsCubit(
          repository: repository,
          summary: summary,
        );

        WidgetsBinding.instance.addPostFrameCallback((_) {
          final languageCode = context.languageCode;
          cubit.fetchSpeakerDetails(languageCode: languageCode);
        });
        return cubit;
      },
      child: const SpeakerDetailsView(),
    );
  }
}
