import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/theme/app_theme.dart';
import '../../../../domain/entities/question_entity.dart';
import '../cubit/quiz_editor_cubit.dart';

class QuestionCreationBottomSheet extends StatelessWidget {
  final ScrollController scrollController;
  const QuestionCreationBottomSheet({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final cubit = context.read<QuizEditorCubit>();

    return BlocBuilder<QuizEditorCubit, QuizEditorState>(
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
                leading: Icon(Icons.abc, color: theme.primaryColor),
              ),
              ListTile(
                onTap: null,
                // onTap: () {
                //   cubit.addNewQuestion(
                //       index: state.currentQuestionIndex,
                //       type: QuestionType.answer);
                //   scrollController.jumpTo(0);
                //   Navigator.pop(context);
                // },
                title: Text(
                  "Adauga intrebare cu raspuns amplu",
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: theme.secondaryColor),
                ),
                leading: const Icon(Icons.edit),
              ),
            ],
          ),
        );
      },
    );
  }
}
