import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/features/quiz/presentation/session/timer/question_timer_cubit.dart';
import 'package:testador/features/quiz/presentation/session/widgets/session_option_widget.dart';

import '../../../../core/components/buttons/app_bar_button.dart';
import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/components/theme/app_theme.dart';
import '../../../../core/utils/split_string_into_blocks.dart';
import '../../domain/entities/question_entity.dart';
import 'session_admin_cubit/session_admin_cubit.dart';

class AnswerRetrivalAdminScreen extends StatefulWidget {
  final VoidCallback onContinue;
  final SessionAdminMatchState state;
  final Function(MultipleChoiceOptionEntity answer) onAnswerPressed;
  const AnswerRetrivalAdminScreen(
      {super.key,
      required this.state,
      required this.onContinue,
      required this.onAnswerPressed});

  @override
  State<AnswerRetrivalAdminScreen> createState() =>
      _AnswerRetrivalAdminScreenState();
}

class _AnswerRetrivalAdminScreenState extends State<AnswerRetrivalAdminScreen> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final state = widget.state;
    return BlocProvider(
      create: (context) => QuestionTimerCubit(time: 40),
      child: Builder(builder: (context) {
        return BlocListener<QuestionTimerCubit, QuestionTimerState>(
          listenWhen: (previous, current) => current.time == 0,
          listener: (context, state) => widget.onContinue(),
          child: Scaffold(
            appBar: CustomAppBar(
                title: Text(splitStringIntoBlocks(widget.state.session.id),
                    style: theme.titleTextStyle),
                trailing: [
                  AppBarButton(text: 'Continua', onPressed: widget.onContinue)
                ]),
            body: NestedScrollView(
              controller: controller,
              headerSliverBuilder: (context, _) {
                return [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                        padding:
                            theme.standardPadding.copyWith(top: 0, bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "#${(state.currentQuestionIndex + 1).toString()} ${state.currentQuestion.text ?? "Cineva a uitat sa puna aici o intrebare 😁"}",
                                    style: theme.subtitleTextStyle,
                                  ),
                                ),
                                SizedBox(width: theme.spacing.small),
                                BlocBuilder<QuestionTimerCubit,
                                    QuestionTimerState>(
                                  builder: (context, state) {
                                    return TimerWidget(seconds: state.time);
                                  },
                                )
                              ],
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
                        onPressed: () => widget.onAnswerPressed(
                            widget.state.currentQuestion.options[index]),
                      )),
            ),
          ),
        );
      }),
    );
  }
}

class TimerWidget extends StatelessWidget {
  final int seconds;
  final double size;
  final Color color;

  const TimerWidget(
      {super.key,
      required this.seconds,
      this.size = 80,
      this.color = Colors.red});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Container(
      width: size,
      height: size,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: theme.primaryColor),
      child: Center(
          child: Text(seconds.toString(),
              style: theme.titleTextStyle.copyWith(color: Colors.white))),
    );
  }
}
