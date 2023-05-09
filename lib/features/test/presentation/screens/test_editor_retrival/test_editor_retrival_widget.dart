import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/routing/app_router.gr.dart';
import '../../../../../../injection.dart';
import '../../../domain/entities/test_entity.dart';
import 'cubit/test_editor_retrival_cubit.dart';

class TestEditorRetrivalWidget extends StatelessWidget {
  const TestEditorRetrivalWidget({
    super.key,
    required this.testId,
    required this.entity,
    required this.builder,
  });

  final Widget Function(TestEditorRetrivalSuccessful state) builder;

  final String testId;
  final TestEntity? entity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TestEditorRetrivalCubit(locator())
        ..initialize(testId: testId, testEntity: entity),
      child: Builder(builder: (context) {
        return BlocConsumer<TestEditorRetrivalCubit, TestEditorRetrivalState>(
          listener: (context, state) {
            if (state is TestEditorRetrivalFailed) {
              //TODO: not found page;

              context.popRoute();
              context.popRoute();
              context.router.root.push(const UnprotectedFlowRoute());
            }
          },
          buildWhen: (previous, current) =>
              previous.runtimeType != current.runtimeType,
          builder: (context, state) {
            if (state is TestEditorRetrivalLoading) {
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            } else if (state is TestEditorRetrivalSuccessful) {
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
