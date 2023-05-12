import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/theme/app_theme.dart';
import '../../../../domain/entities/question_entity.dart';
import '../cubit/test_editor_cubit.dart';

class QuestionCreationBottomSheet extends StatelessWidget {
  final ScrollController scrollController;
  const QuestionCreationBottomSheet({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final cubit = context.read<TestEditorCubit>();

    return BlocBuilder<TestEditorCubit, TestEditorState>(
      builder: (context, state) {
        return Container(
          padding: theme.standardPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  cubit.addNewQuestion(
                    index: state.currentQuestionIndex,
                    type: QuestionType.multipleChoice,
                  );
                  scrollController.jumpTo(0);
                  Navigator.pop(context);
                },
                title: const Text("Adauga intrebare ABC"),
                leading: const Icon(Icons.abc),
              ),
              ListTile(
                onTap: () {
                  cubit.addNewQuestion(
                      index: state.currentQuestionIndex,
                      type: QuestionType.answer);
                  scrollController.jumpTo(0);
                  Navigator.pop(context);
                },
                title: const Text("Adauga intrebare cu raspuns amplu"),
                leading: const Icon(Icons.edit),
              ),
            ],
          ),
        );
      },
    );
  }
}
