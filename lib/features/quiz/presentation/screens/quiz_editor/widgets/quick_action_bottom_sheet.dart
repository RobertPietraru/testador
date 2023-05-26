import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/utils/translator.dart';

import '../../../../../../core/components/theme/app_theme.dart';
import '../../../../domain/entities/question_entity.dart';
import '../cubit/quiz_editor_cubit.dart';
import 'image_retrival_dialog.dart';

class QuickActionBottomSheet extends StatelessWidget {
  final QuestionEntity entity;
  final int questionIndex;
  final ScrollController controller;
  const QuickActionBottomSheet({
    super.key,
    required this.entity,
    required this.questionIndex,
    required this.controller,
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
                context.read<QuizEditorCubit>().suggestOptions(context);
              },
              title: const Text(
                'Suggest options with Ai',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: const Icon(Icons.diversity_2),
            ),
            ListTile(
              onTap: () {
                context.read<QuizEditorCubit>().addNewQuestion();
                controller.jumpTo(0);
                Navigator.pop(context);
              },
              title: Text(
                'Add question',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: const Icon(Icons.add),
            ),
          ]),
    );
  }
}
