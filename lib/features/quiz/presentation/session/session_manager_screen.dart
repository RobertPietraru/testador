import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/routing/app_router.dart';
import 'package:testador/features/quiz/domain/entities/quiz_entity.dart';
import 'package:testador/features/quiz/domain/entities/session/session_entity.dart';
import 'package:testador/features/quiz/presentation/session/cubit/session_admin_cubit.dart';
import 'package:testador/features/quiz/presentation/session/waiting_for_players_screen.dart';
import 'package:testador/injection.dart';

class QuizSessionManagercreen extends StatelessWidget {
  final QuizEntity quiz;
  const QuizSessionManagercreen({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SessionAdminCubit(
          locator(), locator(), locator(), locator(), locator(),
          quiz: quiz),
      child: _QuizSessionManagerScreen(),
    );
  }
}

class _QuizSessionManagerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<SessionAdminCubit>().deleteAndUnsubscribe();
        return true;
      },
      child: BlocBuilder<SessionAdminCubit, SessionAdminState>(
        builder: (context, state) {
          if (state is SessionAdminMatchState) {
            final status = state.session.status;
            if (status == SessionStatus.waitingForPlayers) {
              return WaitingForPlayersScreen(state: state);
            } else if (status == SessionStatus.question) {
              return SessionQuestionScreen();
            }
          }

          return const LoadingScreen();
        },
      ),
    );
  }
}

class SessionQuestionScreen extends StatelessWidget {
  const SessionQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text("QUESTION SCREEN"),
          ),
        ],
      ),
    );
  }
}
