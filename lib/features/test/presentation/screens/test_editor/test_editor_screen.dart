import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/components/app_app_bar.dart';
import 'package:testador/core/components/custom_dialog.dart';
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
        title: Container(),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [],
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
