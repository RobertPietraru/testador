import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/routing/app_router.gr.dart';
import '../../../../../../injection.dart';
import '../../../domain/entities/quiz_entity.dart';
import 'cubit/quiz_editor_retrival_cubit.dart';

class QuizEditorRetrivalWidget extends StatelessWidget {
  const QuizEditorRetrivalWidget({
    super.key,
    required this.quizId,
    required this.entity,
    required this.builder,
  });

  final Widget Function(QuizEditorRetrivalSuccessful state) builder;

  final String quizId;
  final QuizEntity? entity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizEditorRetrivalCubit(locator())
        ..initialize(quizId: quizId, quizEntity: entity),
      child: Builder(builder: (context) {
        return BlocConsumer<QuizEditorRetrivalCubit, QuizEditorRetrivalState>(
          listener: (context, state) {
            if (state is QuizEditorRetrivalFailed) {
              //TODO: not found page;

              context.popRoute();
              context.popRoute();
              context.router.root.push(const UnprotectedFlowRoute());
            }
          },
          buildWhen: (previous, current) =>
              previous.runtimeType != current.runtimeType,
          builder: (context, state) {
            if (state is QuizEditorRetrivalLoading) {
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            } else if (state is QuizEditorRetrivalSuccessful) {
              return builder(state);
            }
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          },
        );
      }),
    );
  }
}
