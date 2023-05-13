import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/theme/app_theme.dart';
import '../../../../domain/entities/question_entity.dart';
import '../cubit/test_editor_cubit.dart';
import 'image_retrival_dialog.dart';

class QuestionSettingsBottomSheet extends StatelessWidget {
  final QuestionEntity entity;
  final int questionIndex;
  const QuestionSettingsBottomSheet({
    super.key,
    required this.entity,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return BlocBuilder<QuizEditorCubit, QuizEditorState>(
      builder: (context, state) {
        return Container(
          padding: theme.standardPadding,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(
                  onTap: () {
                    context
                        .read<QuizEditorCubit>()
                        .deleteQuestion(index: state.currentQuestionIndex);
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
                      context
                          .read<QuizEditorCubit>()
                          .addAnotherRowOfOptions(questionIndex: questionIndex);
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
                      context
                          .read<QuizEditorCubit>()
                          .removeRowOfOptions(questionIndex: questionIndex);
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
                    final cubit = context.read<QuizEditorCubit>();

                    showDialog(
                        context: context,
                        builder: (_) => ImageRetrivalDialog(
                              onImageRetrived: (imageFile) {
                                cubit.updateQuestionImage(image: imageFile);
                              },
                            ));
                    Navigator.pop(context);
                  },
                  title: Text(
                    state.currentQuestion.image == null
                        ? "Adauga o imagine"
                        : "Schimba imaginea",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(Icons.image),
                ),
                ListTile(
                  onTap: () {
                    context
                        .read<QuizEditorCubit>()
                        .deleteQuestion(index: state.currentQuestionIndex);
                    Navigator.pop(context);
                  },
                  title: Text(
                    "Sterge intrebarea",
                    style: TextStyle(
                        color: theme.bad, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(Icons.delete, color: theme.bad),
                )
              ]),
        );
      },
    );
  }
}
