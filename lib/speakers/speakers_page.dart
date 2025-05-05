import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/speakers/cubit/speakers_cubit.dart';
import 'package:flutter_conf_latam/speakers/view/speakers_view.dart';
import 'package:speakers_repository/speakers_repository.dart';

class SpeakersPage extends StatelessWidget {
  const SpeakersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpeakersCubit>(
      create: (context) {
        final repository = context.read<SpeakersRepository>();
        return SpeakersCubit(repository: repository)..fetchSpeakers();
      },
      child: const SpeakersView(),
    );
  }
}
