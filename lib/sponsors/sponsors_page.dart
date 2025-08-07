import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/sponsors/cubit/sponsors_cubit.dart';
import 'package:flutter_conf_latam/sponsors/view/sponsors_view.dart';
import 'package:sponsors_repository/sponsors_repository.dart';

class SponsorsPage extends StatelessWidget {
  const SponsorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SponsorsCubit>(
      create: (context) {
        final repository = context.read<SponsorsRepository>();
        return SponsorsCubit(repository: repository)..loadSponsors();
      },
      child: const SponsorsView(),
    );
  }
}
