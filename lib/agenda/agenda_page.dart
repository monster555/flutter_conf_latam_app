import 'package:agenda_repository/agenda_repository.dart';
import 'package:conf_core/conf_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/agenda/cubit/agenda_cubit.dart';
import 'package:flutter_conf_latam/agenda/view/agenda_view.dart';

class AgendaPage extends StatelessWidget {
  const AgendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AgendaCubit>(
      create: (context) {
        final sessionsRepository = context.read<AgendaRepository>();
        final cubit = AgendaCubit(repository: sessionsRepository);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          final languageCode = context.languageCode;
          cubit.loadAgenda(languageCode: languageCode);
        });

        return cubit;
      },
      child: const AgendaView(),
    );
  }
}
