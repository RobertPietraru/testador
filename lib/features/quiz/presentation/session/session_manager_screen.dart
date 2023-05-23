import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/routing/app_router.dart';
import 'package:testador/features/quiz/domain/entities/quiz_entity.dart';
import 'package:testador/features/quiz/domain/entities/session/session_entity.dart';
import 'package:testador/features/quiz/presentation/screens/quiz_editor/widgets/are_you_sure_dialog.dart';
import 'package:testador/features/quiz/presentation/session/session_admin_cubit/session_admin_cubit.dart';
import 'package:testador/features/quiz/presentation/session/podium_screen.dart';
import 'package:testador/features/quiz/presentation/session/question_results_screen.dart';
import 'package:testador/features/quiz/presentation/session/waiting_for_players_screen.dart';
import 'package:testador/injection.dart';

import 'answer_retrival_admin_screen.dart';
import 'leaderboard_screen.dart';

class QuizSessionManagercreen extends StatelessWidget {
  final QuizEntity quiz;
  const QuizSessionManagercreen({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SessionAdminCubit(locator(), locator(), locator(),
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
        final cubit = context.read<SessionAdminCubit>();
        final result = await showDialog(
          context: context,
          builder: (context) => const AreYouSureDialog(
              text:
                  'Daca iesi, sesiunea de test se va incheia. Esti sigur ca vrei sa faci asta?',
              option1: 'Da',
              option2: 'Ramane'),
        );
        if (result == null) {
          return false;
        }
        if (result == false) {
          // the user wants to leave
          cubit.deleteAndUnsubscribe();
          return true;
        }

        return false;
      },
      child: BlocBuilder<SessionAdminCubit, SessionAdminState>(
        builder: (context, state) {
          if (state is SessionAdminMatchState) {
            final status = state.session.status;
            if (status == SessionStatus.waitingForPlayers) {
              return WaitingForPlayersScreen(state: state);
            } else if (status == SessionStatus.question) {
              return AnswerRetrivalAdminScreen(
                state: state,
                onContinue: () =>
                    context.read<SessionAdminCubit>().showQuestionResults(),
                onAnswerPressed: (answer) {},
              );
            } else if (status == SessionStatus.results) {
              return QuestionResultsScreen(
                onContinue: () {
                  context.read<SessionAdminCubit>().showLeaderboard();
                },
                state: state,
              );
            } else if (status == SessionStatus.leaderboard) {
              return LeaderboardScreen(
                onContinue: () =>
                    context.read<SessionAdminCubit>().goToNextQuestion(),
                state: state,
              );
            } else if (status == SessionStatus.podium) {
              return PodiumScreen(onLeave: () {}, state: state);
            }
          }

          return const LoadingScreen();
        },
      ),
    );
  }
}
