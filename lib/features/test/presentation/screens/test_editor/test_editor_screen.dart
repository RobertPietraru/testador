import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/components/app_app_bar.dart';
import 'package:testador/core/components/loading_wrapper.dart';
import 'package:testador/core/components/theme/app_theme_data.dart';
import 'package:testador/features/test/domain/entities/draft_entity.dart';
import 'package:testador/features/test/domain/entities/question_entity.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
import 'package:testador/features/test/presentation/screens/test_editor/cubit/test_editor_cubit.dart';
import 'package:testador/features/test/presentation/screens/test_editor/test_settings_screen.dart';
import 'package:testador/features/test/presentation/screens/test_editor/views/questions_navigator.dart';
import 'package:testador/features/test/presentation/screens/test_editor/widgets/add_accepted_answer_dialog.dart';
import 'package:testador/features/test/presentation/screens/test_editor/widgets/are_you_sure_dialog.dart';
import 'package:testador/features/test/presentation/screens/test_editor/widgets/edit_accepted_answer.dart';
import 'package:testador/features/test/presentation/screens/test_editor/widgets/option_widget.dart';
import 'package:testador/features/test/presentation/screens/test_editor/widgets/question_creation_bottom_sheet.dart';
import 'package:testador/features/test/presentation/screens/test_list/cubit/test_list_cubit.dart';
import 'package:testador/injection.dart';
import '../../../../../core/components/theme/app_theme.dart';
import '../test_editor_retrival/test_editor_retrival_widget.dart';

class TestEditorScreen extends StatelessWidget {
  const TestEditorScreen(
      {super.key,
      @PathParam('id') required this.testId,
      this.test,
      this.testListCubit,
      this.draft});
  final String testId;
  final TestEntity? test;
  final DraftEntity? draft;
  final TestListCubit? testListCubit;

  @override
  Widget build(BuildContext context) {
    return TestEditorRetrivalWidget(
        testId: testId,
        entity: test,
        builder: (state) {
          return BlocProvider(
              create: (context) => TestEditorCubit(
                    locator(),
                    locator(),
                    locator(),
                    locator(),
                    locator(),
                    locator(),
                    locator(),
                    locator(),
                    locator(),
                    initialDraft: draft,
                    testListCubit: testListCubit,
                    initialTest: state.entity,
                  ),
              child: const _TestScreen());
        });
  }
}

class _TestScreen extends StatefulWidget {
  const _TestScreen();

  @override
  State<_TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<_TestScreen> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return WillPopScope(
      onWillPop: () async {
        final cubit = context.read<TestEditorCubit>();
        if (!cubit.state.needsSync) {
          return true;
        }
        final bool? gottaSave = await showDialog(
          context: context,
          builder: (context) => const AreYouSureDialog(),
        );
        if (gottaSave == null) {
          // it was dissmissed;
          return false;
        }

        if (gottaSave) {
          await context.read<TestEditorCubit>().save();
        } else {
          context.read<TestEditorCubit>().deleteDraft();
        }
        return true;
      },
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
              backgroundColor: theme.primaryColor,
              onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (_) => BlocProvider.value(
                      value: context.read<TestEditorCubit>(),
                      child: QuestionCreationBottomSheet(
                        scrollController: controller,
                      )),
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0)))),
              child: const Icon(Icons.add)),
          backgroundColor: theme.defaultBackgroundColor.withOpacity(0.9),
          resizeToAvoidBottomInset: true,
          bottomSheet: BlocBuilder<TestEditorCubit, TestEditorState>(
            builder: (context, state) => SizedBox(
                height: 100,
                child: ReorderableListView(
                  onReorder: (oldIndex, newIndex) {
                    context
                        .read<TestEditorCubit>()
                        .moveQuestion(oldIndex: oldIndex, newIndex: newIndex);
                  },
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      state.draft.questions.length,
                      (index) => QuestionNavigatorListTile(
                          key: ValueKey('$index'),
                          isSelected: state.currentQuestionIndex == index,
                          onPressed: () {
                            context
                                .read<TestEditorCubit>()
                                .navigateToIndex(index);
                            controller.jumpTo(0);
                          },
                          index: index,
                          question: state.draft.questions[index])),
                )),
          ),
          appBar: CustomAppBar(title: const Text("Editor test"), trailing: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<TestEditorCubit>(),
                          child: const TestSettingsScreen(),
                        ),
                      ));
                },
                icon: const Icon(Icons.settings)),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<TestEditorCubit, TestEditorState>(
                    builder: (context, state) {
                  return LoadingWrapper(
                    isLoading: state.status == TestEditorStatus.loading,
                    child: FilledButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              state.needsSync
                                  ? theme.good
                                  : theme.secondaryColor),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ))),
                      onPressed: state.needsSync
                          ? () => context.read<TestEditorCubit>().save()
                          : null,
                      child: const Text('Salveaza'),
                    ),
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
            builder: (context, state) {
              return NestedScrollView(
                  controller: controller,
                  headerSliverBuilder: (context, _) {
                    return [
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Padding(
                            padding: theme.standardPadding
                                .copyWith(top: 0, bottom: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TestQuestionWidget(state: state),
                                SizedBox(height: theme.spacing.medium),
                                if (state.currentQuestion.type ==
                                    QuestionType.answer)
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        FilledButton(
                                            onPressed: () => showDialog(
                                                context: context,
                                                builder: (_) => BlocProvider.value(
                                                    value: context.read<
                                                        TestEditorCubit>(),
                                                    child:
                                                        const AcceptedAnswerCreationDialog())),
                                            child: const Text(
                                                "Adauga un raspuns acceptat"))
                                      ]),
                                SizedBox(height: theme.spacing.medium),
                                if (state.currentQuestion.image != null)
                                  Center(
                                    child: Container(
                                      height: 220,
                                      color: theme.secondaryColor,
                                      child: AspectRatio(
                                        aspectRatio: 1.0,
                                        child: Image.network(
                                            state.currentQuestion.image!,
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
                  body: state.currentQuestion.type ==
                          QuestionType.multipleChoice
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: state.currentQuestion.options.length,
                          itemBuilder: (context, index) => OptionWidget(
                              index: index,
                              option: state.currentQuestion.options[index]))
                      : buildAnswers(theme, state.currentQuestion));
            },
          )),
    );
  }

  Widget buildAnswers(AppThemeData theme, QuestionEntity question) {
    if (question.acceptedAnswers.isEmpty) {
      return const Expanded(
          child: Center(child: Text('Nu ai adaugat nicio optiune de raspuns')));
    }

    return ListView.separated(
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
                          index: index))),
              leading: const Icon(Icons.lightbulb_outline_sharp),
              title: Text(question.acceptedAnswers[index]),
            )));
  }
}
