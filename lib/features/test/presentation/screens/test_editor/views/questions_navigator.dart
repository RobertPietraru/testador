import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/theme/app_theme.dart';
import '../../../../domain/entities/question_entity.dart';
import '../cubit/test_editor_cubit.dart';
import '../widgets/edit_question_dialog.dart';
import '../widgets/question_settings_bottom_sheet.dart';

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