import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/components/app_app_bar.dart';
import 'package:testador/core/components/custom_dialog.dart';
import 'package:testador/core/components/text_input_field.dart';
import 'package:testador/core/components/theme/app_theme_data.dart';
import 'package:testador/features/test/domain/entities/question_entity.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
import 'package:testador/features/test/presentation/screens/test_editor/cubit/test_editor_cubit.dart';
import 'package:testador/features/test/presentation/screens/test_editor/test_editor_retrival/test_editor_retrival_widget.dart';
import 'package:testador/injection.dart';

import '../../../../../core/components/theme/app_theme.dart';

class TestEditorScreen extends StatelessWidget {
  const TestEditorScreen(
      {super.key, @PathParam('id') required this.testId, this.entity});
  final String testId;
  final TestEntity? entity;

  @override
  Widget build(BuildContext context) {
    return TestEditorRetrivalWidget(
      testId: testId,
      entity: entity,
      builder: (state) => BlocProvider(
        create: (context) => TestEditorCubit(locator(), locator(), locator(),
            initialTest: state.entity),
        child: const _TestScreen(),
      ),
    );
  }
}

class _TestScreen extends StatelessWidget {
  const _TestScreen();
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (_) => QuestionCreationBottomSheet(
                    cubit: context.read<TestEditorCubit>(),
                  ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ));
        },
        child: const Icon(Icons.bolt),
      ),
      backgroundColor: theme.defaultBackgroundColor.withOpacity(0.9),
      resizeToAvoidBottomInset: true,
      bottomSheet: BlocBuilder<TestEditorCubit, TestEditorState>(
        builder: (context, state) {
          final test = state.test;
          return SizedBox(
              height: 100,
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  width: theme.spacing.small,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: test.questions.length,
                itemBuilder: (context, index) => QuestionNavigatorListTile(
                  onPressed: () {
                    context.read<TestEditorCubit>().navigateToIndex(index);
                  },
                  index: index,
                  question: test.questions[index],
                ),
              ));
        },
      ),
      appBar: CustomAppBar(
        title: const Text("Editor test"),
        trailing: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<TestEditorCubit, TestEditorState>(
              builder: (context, state) {
                return FilledButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          state.test != state.lastSavedTest
                              ? theme.good
                              : theme.secondaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ))),
                  onPressed: state.test != state.lastSavedTest ? () {} : null,
                  child: const Text('Salveaza'),
                );
              },
            ),
          ),
        ],
      ),
      body: BlocConsumer<TestEditorCubit, TestEditorState>(
        listener: (context, state) {
          if (state.status == TestEditorStatus.failed &&
              state.failure != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.failure!.retrieveMessage(context))));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: theme.standardPadding,
                    child: const TestQuestionWidget(),
                  ),
                  if (state.currentQuestion is TextInputQuestionEntity)
                    Padding(
                      padding: theme.standardPadding.copyWith(top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FilledButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => BlocProvider.value(
                                        value: context.read<TestEditorCubit>(),
                                        child:
                                            const AcceptedAnswerCreationDialog(),
                                      ));
                            },
                            child: const Text("Adauga optiune"),
                          ),
                        ],
                      ),
                    ),
                  if (state.currentQuestion is MultipleChoiceQuestionEntity)
                    Flexible(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: (state.currentQuestion
                                as MultipleChoiceQuestionEntity)
                            .options
                            .length,
                        itemBuilder: (context, index) =>
                            MultipleChoiceOptionWidget(
                                index: index,
                                option: (state.currentQuestion
                                        as MultipleChoiceQuestionEntity)
                                    .options[index]),
                      ),
                    )
                  else
                    buildAnswers(theme,
                        state.currentQuestion as TextInputQuestionEntity),
                  const SizedBox(),
                ],
              ),
              if (state.status == TestEditorStatus.loading)
                BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                        color: theme.defaultBackgroundColor.withOpacity(0.7),
                        child:
                            const Center(child: CircularProgressIndicator()))),
            ],
          );
        },
      ),
    );
  }

  Widget buildAnswers(AppThemeData theme, TextInputQuestionEntity question) {
    if (question.acceptedAnswers.isEmpty) {
      return const Expanded(
          child: Center(child: Text('Nu ai adaugat nicio optiune de raspuns')));
    }

    return Flexible(
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: question.acceptedAnswers.length,
        itemBuilder: (context, index) => Padding(
          padding: theme.standardPadding.copyWith(bottom: 0),
          child: ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => BlocProvider.value(
                  value: context.read<TestEditorCubit>(),
                  child: ModifyAnswerOptionDialog(
                    initialValue: question.acceptedAnswers[index],
                    index: index,
                  ),
                ),
              );
            },
            leading: const Icon(Icons.lightbulb_outline_sharp),
            title: Text(question.acceptedAnswers[index]),
          ),
        ),
      ),
    );
  }
}

class AcceptedAnswerCreationDialog extends StatefulWidget {
  const AcceptedAnswerCreationDialog({super.key});

  @override
  State<AcceptedAnswerCreationDialog> createState() =>
      _AcceptedAnswerCreationDialogState();
}

class _AcceptedAnswerCreationDialogState
    extends State<AcceptedAnswerCreationDialog> {
  String value = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return CustomDialog(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextInputField(
          initialValue: value,
          onChanged: (e) => setState(() => value = e),
          hint: 'Apasa pentru a edita raspunsul',
          backgroundColor: Colors.transparent,
          showLabel: false,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(theme.good),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ))),
              onPressed: () {
                if (value.isNotEmpty) {
                  context
                      .read<TestEditorCubit>()
                      .addAcceptedAnswer(answer: value);
                }
                Navigator.pop(context);
              },
              child: const Text('Salveaza'),
            )
          ],
        )
      ],
    ));
  }
}

class MultipleChoiceOptionWidget extends StatefulWidget {
  final int index;
  final MultipleChoiceOptionEntity option;
  const MultipleChoiceOptionWidget({
    super.key,
    required this.index,
    required this.option,
  });

  @override
  State<MultipleChoiceOptionWidget> createState() =>
      _MultipleChoiceOptionWidgetState();
}

class _MultipleChoiceOptionWidgetState
    extends State<MultipleChoiceOptionWidget> {
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
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<TestEditorCubit>(),
              child: _MultipleChoiceOptionEditDialog(
                entity: widget.option,
                index: widget.index,
              ),
            ),
          );
        },
        child: Ink(
          color: isEnabled ? getColor(widget.index) : theme.secondaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () => context
                          .read<TestEditorCubit>()
                          .updateCurrentQuestionOption(
                              optionIndex: widget.index,
                              newOption: MultipleChoiceOptionEntity(
                                  text: widget.option.text,
                                  isCorrect: !widget.option.isCorrect)),
                      icon: Icon(
                          widget.option.isCorrect ? Icons.done : Icons.close,
                          color: Colors.white)),
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

class _MultipleChoiceOptionEditDialog extends StatefulWidget {
  final MultipleChoiceOptionEntity entity;
  final int index;
  const _MultipleChoiceOptionEditDialog(
      {required this.entity, required this.index});

  @override
  State<_MultipleChoiceOptionEditDialog> createState() =>
      _MultipleChoiceOptionEditDialogState();
}

class _MultipleChoiceOptionEditDialogState
    extends State<_MultipleChoiceOptionEditDialog> {
  late String value;
  late bool isCorrect;

  @override
  void initState() {
    value = widget.entity.text ?? '';
    isCorrect = widget.entity.isCorrect;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return CustomDialog(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextInputField(
          initialValue: value,
          onChanged: (e) => setState(() => value = e),
          hint: 'Apasa pentru a edita raspunsul',
          backgroundColor: Colors.transparent,
          showLabel: false,
        ),
        CheckboxListTile(
          value: isCorrect,
          onChanged: (e) => setState(() => isCorrect = !isCorrect),
          title: const Text("Este corect?"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(theme.good),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ))),
              onPressed: () {
                context.read<TestEditorCubit>().updateCurrentQuestionOption(
                    optionIndex: widget.index,
                    newOption: MultipleChoiceOptionEntity(
                        text: value.isEmpty ? null : value,
                        isCorrect: isCorrect));
                Navigator.pop(context);
              },
              child: const Text('Salveaza'),
            )
          ],
        )
      ],
    ));
  }
}

class QuestionCreationBottomSheet extends StatelessWidget {
  final TestEditorCubit cubit;
  const QuestionCreationBottomSheet({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Container(
      padding: theme.standardPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              cubit.addNewQuestion(
                  index: cubit.state.currentQuestionIndex,
                  type: QuestionType.multipleChoice);
              Navigator.pop(context);
            },
            title: const Text("Adauga intrebare ABC"),
            leading: const Icon(Icons.abc),
          ),
          ListTile(
            onTap: () {
              cubit.addNewQuestion(
                  index: cubit.state.currentQuestionIndex,
                  type: QuestionType.answer);
              Navigator.pop(context);
            },
            title: const Text("Adauga intrebare cu raspuns amplu"),
            leading: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}

class EditQuestionDialog extends StatefulWidget {
  final String initialValue;
  const EditQuestionDialog({super.key, required this.initialValue});

  @override
  State<EditQuestionDialog> createState() => _EditQuestionDialogState();
}

class _EditQuestionDialogState extends State<EditQuestionDialog> {
  late String value;
  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return CustomDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextInputField(
            onChanged: (e) => setState(() => value = e),
            initialValue: value,
            hint: 'Apasa pentru a modifica intrebarea',
            showLabel: true,
          ),
          SizedBox(height: theme.spacing.medium),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(theme.good),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ))),
                onPressed: () {
                  if (value.isEmpty) {
                    context
                        .read<TestEditorCubit>()
                        .updateCurrentQuestionText(newText: null);
                  } else {
                    context
                        .read<TestEditorCubit>()
                        .updateCurrentQuestionText(newText: value);
                  }
                  Navigator.pop(context);
                },
                child: const Text('Salveaza'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ModifyAnswerOptionDialog extends StatefulWidget {
  final String initialValue;
  final int index;
  const ModifyAnswerOptionDialog(
      {super.key, required this.initialValue, required this.index});

  @override
  State<ModifyAnswerOptionDialog> createState() =>
      _ModifyAnswerOptionDialogState();
}

class _ModifyAnswerOptionDialogState extends State<ModifyAnswerOptionDialog> {
  late String value;
  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return CustomDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextInputField(
            onChanged: (e) {
              setState(() {
                value = e;
              });
            },
            initialValue: widget.initialValue,
            hint: 'Apasa pentru a modifica optiunea',
            showLabel: false,
          ),
          SizedBox(height: theme.spacing.medium),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(theme.bad),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ))),
                onPressed: () {
                  context
                      .read<TestEditorCubit>()
                      .removeAcceptedAnswer(index: widget.index);
                  Navigator.pop(context);
                },
                child: const Text('Sterge'),
              ),
              SizedBox(width: theme.spacing.small),
              FilledButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(theme.good),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ))),
                onPressed: () {
                  context
                      .read<TestEditorCubit>()
                      .updateAcceptedAnswer(index: widget.index, answer: value);
                  Navigator.pop(context);
                },
                child: const Text('Salveaza'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class QuestionSettingsBottomSheet extends StatelessWidget {
  final TestEditorCubit cubit;
  final QuestionEntity entity;
  final int questionIndex;
  const QuestionSettingsBottomSheet({
    super.key,
    required this.cubit,
    required this.entity,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Container(
      padding: theme.standardPadding,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              onTap: () {
                cubit.deleteQuestion(
                  index: cubit.state.currentQuestionIndex,
                );
                Navigator.pop(context);
              },
              title: const Text(
                "Sugereaza continutul cu A.I.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: const Icon(Icons.diversity_2),
            ),
            if (entity.type == QuestionType.multipleChoice)
              ListTile(
                onTap: () {
                  cubit.addAnotherRowOfOptions(questionIndex: questionIndex);

                  Navigator.pop(context);
                },
                title: const Text(
                  "Adauga un rand de optiuni",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.add),
              ),
            if (entity.type == QuestionType.multipleChoice)
              ListTile(
                onTap: () {
                  cubit.removeRowOfOptions(questionIndex: questionIndex);
                  Navigator.pop(context);
                },
                title: const Text(
                  "Inlatura un rand de optiuni",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.remove),
              ),
            ListTile(
              onTap: () {
                cubit.deleteQuestion(index: cubit.state.currentQuestionIndex);
                Navigator.pop(context);
              },
              title: Text(
                "Sterge intrebarea",
                style: TextStyle(color: theme.bad, fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.delete,
                color: theme.bad,
              ),
            ),
          ]),
    );
  }
}

class QuestionNavigatorListTile extends StatelessWidget {
  final int index;
  final QuestionEntity question;
  final VoidCallback onPressed;
  const QuestionNavigatorListTile({
    super.key,
    required this.index,
    required this.question,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Card(
      color: Colors.blue,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(8),
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 84,
                child: Text(
                  question.text ?? 'Nu are intrebare',
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: theme.spacing.small),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              question.image ?? theme.placeholderImage))),
                ),
              ),
              Text(
                (index + 1).toString(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TestQuestionWidget extends StatelessWidget {
  const TestQuestionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return BlocBuilder<TestEditorCubit, TestEditorState>(
      builder: (context, state) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<TestEditorCubit>(context),
                        child: EditQuestionDialog(
                          initialValue: state.currentQuestion.text ?? '',
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "${(state.currentQuestionIndex + 1).toString()}# ${state.currentQuestion.text ?? "Apasa pentru a modifica intrebarea"}",
                    style: theme.subtitleTextStyle,
                  ),
                ),
              ),
              FilledButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) => QuestionSettingsBottomSheet(
                              questionIndex: state.currentQuestionIndex,
                              cubit: context.read<TestEditorCubit>(),
                              entity: state.currentQuestion,
                            ),
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20.0)),
                        ));
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const CircleBorder()),
                  ),
                  child: const Icon(Icons.more_vert)),
            ]);
      },
    );
  }
}
