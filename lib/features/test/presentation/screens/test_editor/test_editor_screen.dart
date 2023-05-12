import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/components/app_app_bar.dart';
import 'package:testador/core/components/theme/app_theme_data.dart';
import 'package:testador/features/test/domain/entities/question_entity.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
import 'package:testador/features/test/presentation/screens/test_editor/cubit/test_editor_cubit.dart';
import 'package:testador/features/test/presentation/screens/test_editor/views/questions_navigator.dart';
import 'package:testador/features/test/presentation/screens/test_editor/widgets/add_accepted_answer_dialog.dart';
import 'package:testador/features/test/presentation/screens/test_editor/widgets/edit_accepted_answer.dart';
import 'package:testador/features/test/presentation/screens/test_editor/widgets/option_widget.dart';
import 'package:testador/features/test/presentation/screens/test_editor/widgets/question_creation_bottom_sheet.dart';
import 'package:testador/injection.dart';

import '../../../../../core/components/loading_wrapper.dart';
import '../../../../../core/components/theme/app_theme.dart';
import '../test_editor_retrival/test_editor_retrival_widget.dart';

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
            create: (context) => TestEditorCubit(
                locator(), locator(), locator(), locator(),
                initialTest: state.entity),
            child: const _TestScreen()));
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
          onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) => BlocProvider.value(
                    value: context.read<TestEditorCubit>(),
                    child: const QuestionCreationBottomSheet(),
                  ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              )),
          child: const Icon(Icons.add),
        ),
        backgroundColor: theme.defaultBackgroundColor.withOpacity(0.9),
        resizeToAvoidBottomInset: true,
        bottomSheet: BlocBuilder<TestEditorCubit, TestEditorState>(
          builder: (context, state) => SizedBox(
              height: 100,
              child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      SizedBox(width: theme.spacing.small),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.test.questions.length,
                  itemBuilder: (context, index) => QuestionNavigatorListTile(
                      onPressed: () => context
                          .read<TestEditorCubit>()
                          .navigateToIndex(index),
                      index: index,
                      question: state.test.questions[index]))),
        ),
        appBar: CustomAppBar(title: const Text("Editor test"), trailing: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
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
              }))
        ]),
        body: BlocConsumer<TestEditorCubit, TestEditorState>(
            listener: (context, state) {
              if (state.status == TestEditorStatus.failed &&
                  state.failure != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.failure!.retrieveMessage(context))));
              }
            },
            builder: (context, state) => LoadingWrapper(
                isLoading: state.status == TestEditorStatus.loading,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: theme.standardPadding,
                          child: const TestQuestionWidget()),
                      if (state.currentQuestion.type == QuestionType.answer)
                        Padding(
                            padding: theme.standardPadding.copyWith(top: 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FilledButton(
                                      onPressed: () => showDialog(
                                          context: context,
                                          builder: (_) => BlocProvider.value(
                                                value: context
                                                    .read<TestEditorCubit>(),
                                                child:
                                                    const AcceptedAnswerCreationDialog(),
                                              )),
                                      child: const Text(
                                          "Adauga un raspuns acceptat"))
                                ])),
                      if (state.currentQuestion.image != null)
                        Container(
                          width: 300,
                          height: 250, // Adjust this value to fit your layout
                          color: theme.secondaryColor,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Image.network(state.currentQuestion.image!,
                                fit: BoxFit.contain),
                          ),
                        ),
                      if (state.currentQuestion.type ==
                          QuestionType.multipleChoice)
                        Flexible(
                            child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: state.currentQuestion.options.length,
                          itemBuilder: (context, index) => OptionWidget(
                              index: index,
                              option: state.currentQuestion.options[index]),
                        ))
                      else
                        buildAnswers(theme, state.currentQuestion),
                      const SizedBox(),
                    ]))));
  }

  Widget buildAnswers(AppThemeData theme, QuestionEntity question) {
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
                  onTap: () => showDialog(
                      context: context,
                      builder: (_) => BlocProvider.value(
                          value: context.read<TestEditorCubit>(),
                          child: EditAcceptedAnswerDialog(
                            initialValue: question.acceptedAnswers[index],
                            index: index,
                          ))),
                  leading: const Icon(Icons.lightbulb_outline_sharp),
                  title: Text(question.acceptedAnswers[index]),
                ))));
  }
}
