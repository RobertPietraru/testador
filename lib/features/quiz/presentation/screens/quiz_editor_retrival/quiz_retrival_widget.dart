import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/routing/app_router.gr.dart';
import '../../../../../../injection.dart';
import '../../../domain/entities/quiz_entity.dart';
import 'cubit/quiz_retrival_cubit.dart';

class QuizEditorRetrivalWidget extends StatelessWidget {
  const QuizEditorRetrivalWidget({
    super.key,
    required this.quizId,
    required this.entity,
    required this.builder,
  });

  final Widget Function(QuizRetrivalSuccessful state) builder;

  final String quizId;
  final QuizEntity? entity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizRetrivalCubit(locator())
        ..initialize(quizId: quizId, quizEntity: entity),
      child: Builder(builder: (context) {
        return BlocConsumer<QuizRetrivalCubit, QuizRetrivalState>(
          listener: (context, state) {
            if (state is QuizRetrivalFailed) {
              //TODO: not found page;

              context.popRoute();
              context.popRoute();
              context.router.root.push(const UnprotectedFlowRoute());
            }
          },
          buildWhen: (previous, current) =>
              previous.runtimeType != current.runtimeType,
          builder: (context, state) {
            if (state is QuizRetrivalLoading) {
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            } else if (state is QuizRetrivalSuccessful) {
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
