import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/components/components.dart';
import 'package:testador/core/components/custom_app_bar.dart';
import 'package:testador/core/routing/app_router.dart';
import 'package:testador/core/utils/split_string_into_blocks.dart';
import 'package:testador/features/quiz/domain/entities/quiz_entity.dart';
import 'package:testador/features/quiz/domain/entities/session/session_entity.dart';
import 'package:testador/features/quiz/presentation/screens/quiz_editor/widgets/are_you_sure_dialog.dart';
import 'package:testador/features/quiz/presentation/session/cubit/session_admin_cubit.dart';
import 'package:testador/features/quiz/presentation/session/waiting_for_players_screen.dart';
import 'package:testador/injection.dart';

import '../../domain/entities/question_entity.dart';

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
              return SessionQuestionAdminScreen(state: state);
            }
          }

          return const LoadingScreen();
        },
      ),
    );
  }
}

class SessionQuestionAdminScreen extends StatefulWidget {
  final SessionAdminMatchState state;
  const SessionQuestionAdminScreen({super.key, required this.state});

  @override
  State<SessionQuestionAdminScreen> createState() =>
      _SessionQuestionAdminScreenState();
}

class _SessionQuestionAdminScreenState
    extends State<SessionQuestionAdminScreen> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final state = widget.state;
    return Scaffold(
      appBar: CustomAppBar(
          title: Text(splitStringIntoBlocks(widget.state.session.id),
              style: theme.titleTextStyle),
          trailing: [
            AppBarButton(
              text: 'Continua',
              onPressed: () {
                // context.read();
              },
            )
          ]),
      body: NestedScrollView(
        controller: controller,
        headerSliverBuilder: (context, _) {
          return [
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                  padding: theme.standardPadding.copyWith(top: 0, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "#${(state.currentQuestionIndex + 1).toString()} ${state.currentQuestion.text ?? "Cineva a uitat sa puna aici o intrebare 😁"}",
                        style: theme.subtitleTextStyle,
                      ),
                      SizedBox(height: theme.spacing.medium),
                      if (widget.state.currentQuestion.type ==
                          QuestionType.answer)
                        SizedBox(height: theme.spacing.medium),
                      if (widget.state.currentQuestion.image != null)
                        Center(
                          child: Container(
                            height: 220,
                            color: theme.secondaryColor,
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: Image.network(
                                  widget.state.currentQuestion.image!,
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ),
                      SizedBox(height: theme.spacing.medium),
                    ],
                  ))
            ]))
          ];
        },
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: widget.state.currentQuestion.options.length,
            itemBuilder: (context, index) => SessionOptionWidget(
                index: index,
                option: widget.state.currentQuestion.options[index],
                isSelected: false,
                onPressed: () {})),
      ),
    );
  }
}

class SessionOptionWidget extends StatefulWidget {
  final int index;
  final MultipleChoiceOptionEntity option;
  final VoidCallback onPressed;
  final bool isSelected;
  const SessionOptionWidget({
    super.key,
    required this.index,
    required this.option,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  State<SessionOptionWidget> createState() => _SessionOptionWidgetState();
}

class _SessionOptionWidgetState extends State<SessionOptionWidget> {
  Color getColor(int index) {
    return [
      Colors.red,
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.pink,
      Colors.purple
    ][index];
  }

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.option.text != null;
    final theme = AppTheme.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
      child: InkWell(
        onTap: widget.onPressed,
        child: Ink(
          color: isEnabled ? getColor(widget.index) : theme.secondaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (widget.isSelected)
                    const Icon(Icons.done, color: Colors.white)
                ],
              ),
              Center(
                child: Text(
                  widget.option.text ?? "Optiunea ${widget.index + 1}",
                  style: TextStyle(
                      color: isEnabled ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
