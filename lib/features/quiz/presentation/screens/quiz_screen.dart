import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/components/custom_app_bar.dart';
import 'package:testador/core/components/buttons/long_button.dart';
import 'package:testador/core/components/theme/app_theme.dart';
import 'package:testador/core/components/theme/device_size.dart';
import 'package:testador/features/quiz/domain/entities/question_entity.dart';
import 'package:testador/features/quiz/presentation/screens/quiz_list/cubit/quiz_list_cubit.dart';

import '../../../../core/components/theme/app_theme_data.dart';
import '../../../../core/routing/app_router.gr.dart';
import '../../domain/entities/draft_entity.dart';
import '../../domain/entities/quiz_entity.dart';

@RoutePage()
class QuizScreen extends StatelessWidget {
  const QuizScreen(
      {super.key,
      @PathParam('id') required this.quizId,
      required this.quiz,
      this.draft,
      required this.quizListCubit});
  final String quizId;
  final QuizEntity quiz;
  final DraftEntity? draft;
  final QuizListCubit quizListCubit;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    // I wanted to be able to use the word quiz without using the inital quiz,
    final quiz0 = quiz;
    return BlocProvider.value(
      value: quizListCubit,
      child: Builder(builder: (context) {
        return BlocBuilder<QuizListCubit, QuizListState>(
          builder: (context, state) {
            late QuizEntity quiz;
            int index = state.pairs
                .indexWhere((element) => element.quiz.id == quiz0.id);
            if (index == -1) {
              quiz = quiz0;
            } else {
              quiz = state.pairs[index].quiz;
            }

            return Scaffold(
              appBar: const CustomAppBar(showLeading: true),
              body: NestedScrollView(
                  headerSliverBuilder: (context, _) {
                    return [
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                quiz.imageUrl ?? theme.placeholderImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: theme.standardPadding,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(quiz.title ?? "Fara nume",
                                      style: theme.titleTextStyle),
                                  IconButton(
                                    onPressed: () {
                                      context.pushRoute(
                                        QuizEditorRoute(
                                          quizId: quiz.id,
                                          quiz: quiz,
                                          draft: draft,
                                          quizListCubit: quizListCubit,
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: theme.standardPadding
                                  .copyWith(top: 0, bottom: 0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: LongButton(
                                      onPressed: () => context.pushRoute(
                                          QuizSessionManagerRoute(quiz: quiz)),
                                      label: 'Incepe o sesiune',
                                      isLoading: false,
                                    ),
                                  ),
                                  SizedBox(width: theme.spacing.medium),
                                  SizedBox(
                                    width: 30.widthPercent,
                                    child: LongButton(
                                        onPressed: () {},
                                        label: 'Testeaza',
                                        isLoading: false),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ]))
                    ];
                  },
                  body: ListView.builder(
                    itemCount: quiz.questions.length,
                    itemBuilder: (context, index) => QuestionWidget(
                      question: quiz.questions[index],
                      index: index,
                    ),
                  )),
            );
          },
        );
      }),
    );
  }
}

class QuestionWidget extends StatefulWidget {
  final int index;
  final QuestionEntity question;
  const QuestionWidget({
    super.key,
    required this.index,
    required this.question,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Padding(
      padding: theme.standardPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "#${widget.index + 1} ${widget.question.text ?? "Nu a fost adaugata intrebarea"}",
            style: theme.informationTextStyle,
          ),
          buildAnswerSection(theme: theme),
        ],
      ),
    );
  }

  Widget buildAnswerSection({
    required AppThemeData theme,
  }) {
    switch (widget.question.type) {
      case QuestionType.answer:
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final answer = widget.question.acceptedAnswers[index];
            return ListTile(
              key: ValueKey(answer),
              leading: Icon(Icons.done, color: theme.good),
              title: Text(answer),
            );
          },
          itemCount: widget.question.acceptedAnswers.length,
        );
      case QuestionType.multipleChoice:
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final option = widget.question.options[index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              key: ValueKey(option),
              leading: option.isCorrect
                  ? Icon(Icons.done, color: theme.good)
                  : Icon(Icons.close, color: theme.bad),
              title: Text(option.text ?? 'Optiune'),
            );
          },
          itemCount: widget.question.options.length,
        );
      default:
        return Container();
    }
  }
}
