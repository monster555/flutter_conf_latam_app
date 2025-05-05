import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/speaker_details/cubit/speaker_details_cubit.dart';
import 'package:flutter_conf_latam/speaker_details/view/speaker_details_view.dart';
import 'package:speakers_repository/speakers_repository.dart';

class SpeakerDetailsPage extends StatelessWidget {
  const SpeakerDetailsPage(this.speaker, {super.key});

  final Speaker speaker;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpeakerDetailsCubit>(
      create: (context) {
        final repository = context.read<SpeakersRepository>();
        return SpeakerDetailsCubit(repository: repository, speaker: speaker)
          ..fetchSpeakerDetails();
      },
      child: SpeakerDetailsView(speaker),
    );
  }
}
