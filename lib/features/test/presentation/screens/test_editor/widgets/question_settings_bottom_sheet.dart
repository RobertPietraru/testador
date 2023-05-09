import 'package:flutter/material.dart';

import '../../../../../../core/components/theme/app_theme.dart';
import '../../../../domain/entities/question_entity.dart';
import '../cubit/test_editor_cubit.dart';

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