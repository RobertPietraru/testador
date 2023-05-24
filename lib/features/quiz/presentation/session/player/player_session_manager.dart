import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/components/buttons/long_button.dart';
import 'package:testador/core/components/custom_app_bar.dart';
import 'package:testador/core/components/text_input_field.dart';
import 'package:testador/features/quiz/domain/entities/session/session_entity.dart';
import 'package:testador/features/quiz/presentation/session/player/cubit/session_player_cubit.dart';
import 'package:testador/features/quiz/presentation/session/waiting_for_players_screen.dart';
import 'package:testador/injection.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/components/theme/app_theme.dart';

@RoutePage()
class PlayerSessionManagerScreen extends StatelessWidget {
  const PlayerSessionManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SessionPlayerCubit(locator(), locator(), userId: Uuid().v1()),
      child: Builder(builder: (context) {
        return BlocBuilder<SessionPlayerCubit, SessionPlayerState>(
          builder: (context, state) {
            if (state is SessionPlayerCodeRetrival) {
              return CodeRetrivalScreen(state: state);
            } else if (state is SessionPlayerNameRetrival) {
              return NameRetrivalScreen(state: state);
            } else {
              state as SessionPlayerInGame;
              switch (state.session.status) {
                case SessionStatus.waitingForPlayers:
                  return WaitingForPlayersScreen(session: state.session);
                case SessionStatus.question:
                  return Scaffold(body: Text("QUESTION"));

                default:
              }
              return SessionPlayerInGameScreen(state: state);
            }
          },
        );
      }),
    );
  }
}

class CodeRetrivalScreen extends StatelessWidget {
  final SessionPlayerCodeRetrival state;
  const CodeRetrivalScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: theme.standardPadding,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Introdu codul pentru a te conecta',
                    style: theme.titleTextStyle,
                  ),
                  SizedBox(height: theme.spacing.small),
                  TextInputField(
                    initialValue: state.sessionId,
                    onChanged: (e) =>
                        context.read<SessionPlayerCubit>().updateCode(e),
                    error: state.failure?.retrieveMessage(context),
                    hint: 'Codul',
                    showLabel: false,
                  ),
                ],
              ),
              LongButton(
                onPressed: () =>
                    context.read<SessionPlayerCubit>().subscribeToSession(),
                label: 'Cauta sesiunea',
                isLoading: state.isLoading,
              ),
            ]),
      ),
    );
  }
}

class NameRetrivalScreen extends StatelessWidget {
  final SessionPlayerNameRetrival state;
  const NameRetrivalScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: theme.standardPadding,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alege-ti un nume',
                    style: theme.titleTextStyle,
                  ),
                  SizedBox(height: theme.spacing.small),
                  TextInputField(
                    initialValue: state.name,
                    onChanged: (e) => context
                        .read<SessionPlayerCubit>()
                        .updateName(e.replaceAll(' ', '')),
                    hint: 'Nume',
                    error: state.failure?.retrieveMessage(context),
                    showLabel: false,
                  ),
                ],
              ),
              LongButton(
                onPressed: () =>
                    context.read<SessionPlayerCubit>().joinSession(),
                label: 'Conecteaza-te',
                isLoading: false,
              ),
            ]),
      ),
    );
  }
}

class SessionPlayerInGameScreen extends StatelessWidget {
  final SessionPlayerInGame state;
  const SessionPlayerInGameScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: theme.standardPadding,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, children: []),
      ),
    );
  }
}
