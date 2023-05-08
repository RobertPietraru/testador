import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/components/app_app_bar.dart';
import 'package:testador/core/components/custom_dialog.dart';
import 'package:testador/core/components/text_input_field.dart';
import 'package:testador/core/components/theme/app_theme_data.dart';
import 'package:testador/core/components/theme/device_size.dart';
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
                itemBuilder: (context, index) => QuestionListTile(
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
            child: FilledButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(theme.good),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ))),
              onPressed: () {},
              child: const Text('Salveaza'),
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
                    child: buildQuestionNavigationBar(state, theme, context),
                  ),
                  Padding(
                    padding: theme.standardPadding,
                    child: TextInputField(
                      maxLines: 3,
                      onChanged: (e) {},
                      hint: 'Intrebarea',
                    ),
                  ),
                  Flexible(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: [
                        const MultipleChoiceOptionWidget(
                          entity: MultipleChoiceOptionEntity(
                            isCorrect: true,
                            text: 'This is my thing',
                          ),
                          index: 0,
                        ),
                        MultipleChoiceOptionWidget(
                          entity: MultipleChoiceOptionEntity(
                            isCorrect: true,
                            text: 'This is my thing',
                          ),
                          index: 1,
                        ),
                        MultipleChoiceOptionWidget(
                          entity: MultipleChoiceOptionEntity(
                            isCorrect: true,
                            text: 'This is my thing',
                          ),
                          index: 2,
                        ),
                        MultipleChoiceOptionWidget(
                          entity: MultipleChoiceOptionEntity(
                            isCorrect: true,
                            text: 'This is my thing',
                          ),
                          index: 3,
                        ),
                      ],
                    ),
                  ),
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

  Row buildQuestionNavigationBar(
      TestEditorState state, AppThemeData theme, BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        child: Text(
          "${(state.currentQuestionIndex + 1).toString()}# ${state.currentQuestion.type != QuestionType.answer ? "Intrebare cu raspuns liber" : "Intrebare cu selectare raspuns corect"}",
          style: theme.subtitleTextStyle,
        ),
      ),
      FilledButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (_) => QuestionSettingsBottomSheet(
                      cubit: context.read<TestEditorCubit>(),
                    ),
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                ));
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder())),
          child: const Icon(Icons.more_vert)),
    ]);
  }
}

class MultipleChoiceOptionWidget extends StatelessWidget {
  final int index;
  final MultipleChoiceOptionEntity entity;
  const MultipleChoiceOptionWidget({
    super.key,
    required this.index,
    required this.entity,
  });

  Color goodColor(int index) {
    return [
      Colors.red,
      Colors.blue,
      Colors.yellow,
      Colors.green,
      Colors.pink,
      Colors.purple
    ][index];
  }

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = entity.text != null;
    final theme = AppTheme.of(context);

    return Card(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextInputField(
                  onChanged: (e) {},
                  showLabel: false,
                  hint: 'Apasa pentru a edita raspunsul',
                  backgroundColor: Colors.transparent,
                ),
                CheckboxListTile(
                  value: false,
                  onChanged: (e) {},
                  title: const Text("Este corect?"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(theme.good),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ))),
                      onPressed: () {},
                      child: const Text('Salveaza'),
                    )
                  ],
                )
              ],
            )),
          );
        },
        child: Ink(
          color: isEnabled ? goodColor(index) : null,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: Text(
              entity.text ?? "Raspunsul nr ${index + 1}",
              style: TextStyle(
                  color: isEnabled ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
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
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
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
        ListTile(
          onTap: () {},
          title: Text(
              "Sugereaza o intrebare si niste raspunsuri cu inteligenta artificiala"),
          leading: Icon(
            Icons.diversity_2,
            color: theme.primaryColor,
          ),
        )
      ]),
    );
  }
}

class QuestionSettingsBottomSheet extends StatelessWidget {
  final TestEditorCubit cubit;
  const QuestionSettingsBottomSheet({
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              onTap: () {
                cubit.deleteQuestion(
                  index: cubit.state.currentQuestionIndex,
                );
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

class QuestionListTile extends StatelessWidget {
  final int index;
  final QuestionEntity question;
  final VoidCallback onPressed;
  const QuestionListTile({
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

class QuestionCreationDialog extends StatelessWidget {
  const QuestionCreationDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return CustomDialog(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ChoiceWidget(
            icon: Icons.done,
            label: 'Bifat',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          ChoiceWidget(
            icon: Icons.edit,
            label: 'Raspuns',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class ChoiceWidget extends StatefulWidget {
  const ChoiceWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Function() onPressed;

  @override
  State<ChoiceWidget> createState() => _ChoiceWidgetState();
}

class _ChoiceWidgetState extends State<ChoiceWidget> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    final double size = 10.widthPercent;
    final theme = AppTheme.of(context);

    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (details) => setState(() => isPressed = true),
      onTapUp: (details) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: isPressed
                  ? theme.primaryColor.withOpacity(0.8)
                  : theme.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              widget.icon,
              color: theme.defaultBackgroundColor,
              size: size / 2,
            ),
          ),
          SizedBox(height: theme.spacing.small),
          Text(
            widget.label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
