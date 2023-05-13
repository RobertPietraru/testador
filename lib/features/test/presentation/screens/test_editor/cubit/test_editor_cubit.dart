import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/features/test/domain/entities/question_entity.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
import 'package:testador/features/test/domain/failures/test_editor/deleting_the_only_question_failure.dart';
import 'package:testador/features/test/domain/failures/test_failures.dart';
import 'package:testador/features/test/domain/usecases/test_usecases.dart';
import 'package:uuid/uuid.dart';

import '../../test_list/cubit/test_list_cubit.dart';

part 'test_editor_state.dart';

class TestEditorCubit extends Cubit<TestEditorState> {
  final InsertQuestionUsecase insertQuestionUsecase;
  final UpdateQuestionUsecase updateQuestionUsecase;
  final DeleteQuestionUsecase deleteQuestionUsecase;
  final UpdateQuestionImageUsecase updateQuestionImageUsecase;
  final MoveQuestionUsecase moveQuestionUsecase;
  final UpdateTestImageUsecase updateTestImageUsecase;
  final UpdateTestUsecase editTestUsecase;
  final SyncTestUsecase syncTestUsecase;

  final TestListCubit? testListCubit;

  TestEditorCubit(
    this.syncTestUsecase,
    this.insertQuestionUsecase,
    this.updateQuestionUsecase,
    this.deleteQuestionUsecase,
    this.updateQuestionImageUsecase,
    this.moveQuestionUsecase,
    this.updateTestImageUsecase,
    this.editTestUsecase, {
    required TestEntity initialTest,
    required this.testListCubit,
  }) : super(TestEditorState(
            currentQuestionIndex: 0,
            lastSavedTest: initialTest,
            test: initialTest,
            failure: null,
            status: TestEditorStatus.loaded));

  void navigateToIndex(int index) {
    emit(state.copyWith(currentQuestionIndex: index));
  }

  Future<void> insertQuestion(
      {required int index, required QuestionEntity question}) async {
    emit(state.copyWith(
        status: TestEditorStatus.loading, failure: null, updateError: true));
    final response =
        await insertQuestionUsecase.call(InsertQuestionUsecaseParams(
      test: state.test,
      question: question,
      index: index,
    ));
    response.fold(
      (l) => emit(state.copyWith(
        failure: l,
        status: TestEditorStatus.failed,
        updateError: true,
      )),
      (r) => emit(state.copyWith(
          failure: null,
          status: TestEditorStatus.loaded,
          updateError: true,
          test: r.test,
          currentQuestionIndex: index)),
    );
  }

  Future<void> addNewQuestion(
      {required int index, required QuestionType type}) async {
    emit(state.copyWith(status: TestEditorStatus.loading, failure: null));
    final response = await insertQuestionUsecase.call(
      InsertQuestionUsecaseParams(
        test: state.test,
        question: QuestionEntity(
          id: const Uuid().v1(),
          testId: state.test.id,
          acceptedAnswers: [],
          options: type == QuestionType.multipleChoice
              ? const [
                  MultipleChoiceOptionEntity(text: null),
                  MultipleChoiceOptionEntity(text: null)
                ]
              : [],
          text: null,
          type: type,
          image: null,
        ),
        index: index + 1,
      ),
    );
    response.fold(
      (l) => emit(state.copyWith(
        failure: l,
        status: TestEditorStatus.failed,
        updateError: true,
      )),
      (r) => emit(state.copyWith(
          failure: null,
          status: TestEditorStatus.loaded,
          updateError: true,
          test: r.test,
          currentQuestionIndex: index + 1)),
    );
  }

  Future<void> addAnotherRowOfOptions({
    required int questionIndex,
  }) async {
    final question = state.currentQuestion;
    if (question.options.length >= 4) {
      //TODO error message
      return;
    }
    emit(state.copyWith(status: TestEditorStatus.loading, failure: null));

    final response =
        await updateQuestionUsecase.call(UpdateQuestionUsecaseParams(
      test: state.test,
      replacementQuestion: question.copyWith(options: [
        ...question.options,
        const MultipleChoiceOptionEntity(text: null),
        const MultipleChoiceOptionEntity(text: null),
      ]),
      index: questionIndex,
    ));

    response.fold(
      (l) => emit(state.copyWith(
        failure: l,
        status: TestEditorStatus.failed,
        updateError: true,
      )),
      (r) => emit(state.copyWith(
        failure: null,
        status: TestEditorStatus.loaded,
        updateError: true,
        test: r.testEntity,
      )),
    );
  }

  Future<void> removeRowOfOptions({
    required int questionIndex,
  }) async {
    final question = state.currentQuestion;
    if (question.options.length <= 2) {
      //TODO error message
      return;
    }
    emit(state.copyWith(status: TestEditorStatus.loading, failure: null));
    final questions = question.options.toList();
    questions.removeLast();
    questions.removeLast();

    final response =
        await updateQuestionUsecase.call(UpdateQuestionUsecaseParams(
      test: state.test,
      replacementQuestion: state.currentQuestion.copyWith(options: questions),
      index: questionIndex,
    ));

    response.fold(
      (l) => emit(state.copyWith(
        failure: l,
        status: TestEditorStatus.failed,
        updateError: true,
      )),
      (r) => emit(state.copyWith(
        failure: null,
        status: TestEditorStatus.loaded,
        updateError: true,
        test: r.testEntity,
      )),
    );
  }

  Future<void> deleteQuestion({required int index}) async {
    int newIndex = index;
    // if we'ere deleting the only question, stop
    if (state.test.questions.length == 1) {
      emit(state.copyWith(
        updateError: true,
        failure: DeletingTheOnlyQuestionTestFailure(),
        status: TestEditorStatus.failed,
      ));
      return;
    }
    // if we're deleting the current question and it's the last one, we can't leave the same index cause it will be out of bounds
    // we subtract one
    if (state.test.questions.length - 1 == index) {
      newIndex = index - 1;
    }

    emit(state.copyWith(status: TestEditorStatus.loading, failure: null));
    final response = await deleteQuestionUsecase
        .call(DeleteQuestionUsecaseParams(test: state.test, index: index));
    response.fold(
      (l) => emit(state.copyWith(
        failure: l,
        status: TestEditorStatus.failed,
        updateError: true,
      )),
      (r) => emit(state.copyWith(
        failure: null,
        status: TestEditorStatus.loaded,
        test: r.testEntity,
        currentQuestionIndex: newIndex,
      )),
    );
  }

  Future<void> updateQuestion(
      {required int index, required QuestionEntity replacementQuestion}) async {
    emit(state.copyWith(status: TestEditorStatus.loading, failure: null));

    final response = await updateQuestionUsecase.call(
        UpdateQuestionUsecaseParams(
            test: state.test,
            index: index,
            replacementQuestion: replacementQuestion));

    response.fold(
      (l) => emit(state.copyWith(
          failure: l, status: TestEditorStatus.failed, updateError: true)),
      (r) {
        emit(state.copyWith(
            failure: null,
            status: TestEditorStatus.loaded,
            test: r.testEntity,
            currentQuestionIndex: index));
      },
    );
  }

  Future<void> updateCurrentQuestionOption(
      {required int optionIndex,
      required MultipleChoiceOptionEntity newOption}) async {
    final question = state.currentQuestion;
    final options = question.options.toList();
    options[optionIndex] = newOption;
    await updateQuestion(
        index: state.currentQuestionIndex,
        replacementQuestion: question.copyWith(options: options));
  }

  Future<void> updateCurrentQuestionText({required String? newText}) async =>
      await updateQuestion(
        index: state.currentQuestionIndex,
        replacementQuestion: state.currentQuestion.copyWith(
          text: newText,
        ),
      );

  Future<void> updateQuestionImage({required File image}) async {
    emit(state.copyWith(status: TestEditorStatus.loading, failure: null));
    final response = await updateQuestionImageUsecase.call(
        UpdateQuestionImageUsecaseParams(
            test: state.test, image: image, index: state.currentQuestionIndex));
    response.fold(
      (l) {
        emit(state.copyWith(
          failure: l,
          status: TestEditorStatus.failed,
          updateError: true,
        ));
      },
      (r) {
        emit(state.copyWith(
            failure: null, status: TestEditorStatus.loaded, test: r.test));
      },
    );
  }

  Future<void> addAcceptedAnswer({required String answer}) async {
    final question = state.currentQuestion;

    await updateQuestion(
        index: state.currentQuestionIndex,
        replacementQuestion: question
            .copyWith(acceptedAnswers: [...question.acceptedAnswers, answer]));
  }

  Future<void> removeAcceptedAnswer({required int index}) async {
    final question = state.currentQuestion;

    final answers = question.acceptedAnswers.toList();
    answers.removeAt(index);

    await updateQuestion(
        index: state.currentQuestionIndex,
        replacementQuestion: question.copyWith(acceptedAnswers: answers));
  }

  Future<void> updateAcceptedAnswer(
      {required int index, required String answer}) async {
    final question = state.currentQuestion;

    final answers = question.acceptedAnswers.toList();
    answers[index] = answer;

    final newQuestion = question.copyWith(acceptedAnswers: answers);
    await updateQuestion(
        index: state.currentQuestionIndex, replacementQuestion: newQuestion);
  }

  Future<void> moveQuestion(
      {required int oldIndex, required int newIndex}) async {
    emit(state.copyWith(status: TestEditorStatus.loading, failure: null));
    final response = await moveQuestionUsecase.call(MoveQuestionUsecaseParams(
        newIndex: newIndex, oldIndex: oldIndex, test: state.test));

    response.fold(
      (l) {
        emit(state.copyWith(
          failure: l,
          status: TestEditorStatus.failed,
          updateError: true,
        ));
      },
      (r) {
        emit(state.copyWith(
          failure: null,
          status: TestEditorStatus.loaded,
          test: r.test,
          currentQuestionIndex: r.test.questions.indexOf(state.currentQuestion),
          updateError: true,
        ));
      },
    );
  }

  Future<void> updateTestImage({required File newImage}) async {
    emit(state.copyWith(
        status: TestEditorStatus.loading, failure: null, updateError: true));

    final response = await updateTestImageUsecase
        .call(UpdateTestImageUsecaseParams(test: state.test, image: newImage));

    response.fold(
      (l) {
        emit(state.copyWith(
            failure: l, status: TestEditorStatus.failed, updateError: true));
      },
      (r) {
        emit(state.copyWith(
            failure: null,
            status: TestEditorStatus.loaded,
            test: r.test,
            updateError: true));
      },
    );
  }

  Future<void> togglePublicity() async {
    emit(state.copyWith(
        status: TestEditorStatus.loading, failure: null, updateError: true));

    final response = await editTestUsecase.call(UpdateTestUsecaseParams(
        test: state.test.copyWith(isPublic: !state.test.isPublic),
        testId: state.test.id));

    response.fold(
      (l) => emit(state.copyWith(
          failure: l, status: TestEditorStatus.failed, updateError: true)),
      (r) => emit(state.copyWith(
          failure: null,
          status: TestEditorStatus.loaded,
          test: r.test,
          updateError: true)),
    );
  }

  Future<void> updateTestTitle(String title) async {
    emit(state.copyWith(
        status: TestEditorStatus.loading, failure: null, updateError: true));

    final response = await editTestUsecase.call(UpdateTestUsecaseParams(
        test: state.test.copyWith(title: title), testId: state.test.id));

    response.fold(
      (l) => emit(state.copyWith(
          failure: l, status: TestEditorStatus.failed, updateError: true)),
      (r) => emit(state.copyWith(
          failure: null,
          status: TestEditorStatus.loaded,
          test: r.test,
          updateError: true)),
    );
  }

  Future<void> save() async {
    emit(state.copyWith(
        status: TestEditorStatus.loading, failure: null, updateError: true));
    final response =
        await syncTestUsecase.call(SyncTestUsecaseParams(test: state.test));
    response.fold((l) {
      emit(state.copyWith(
        failure: l,
        status: TestEditorStatus.failed,
        updateError: true,
      ));
    }, (r) {
      testListCubit?.updateTest(newTest: r.test, oldTest: state.lastSavedTest);
      emit(state.copyWith(
        failure: null,
        status: TestEditorStatus.loaded,
        lastSavedTest: r.test,
        test: r.test,
        updateError: true,
      ));
    });
  }
}
