import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/features/test/domain/entities/question_entity.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
import 'package:testador/features/test/domain/failures/test_editor/deleting_the_only_question_failure.dart';
import 'package:testador/features/test/domain/failures/test_failures.dart';
import 'package:testador/features/test/domain/usecases/test_usecases.dart';

part 'test_editor_state.dart';

class TestEditorCubit extends Cubit<TestEditorState> {
  final InsertQuestionUsecase insertQuestionUsecase;
  final UpdateQuestionUsecase updateQuestionUsecase;
  final DeleteQuestionUsecase deleteQuestionUsecase;

  TestEditorCubit(this.insertQuestionUsecase, this.updateQuestionUsecase,
      this.deleteQuestionUsecase, {required TestEntity initialTest})
      : super(TestEditorState(
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
    emit(state.copyWith(status: TestEditorStatus.loading, failure: null));
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
          test: r.test,
          currentQuestionIndex: index)),
    );
  }

  Future<void> addNewQuestion(
      {required int index, required QuestionType type}) async {
    emit(state.copyWith(status: TestEditorStatus.loading, failure: null));
    final response =
        await insertQuestionUsecase.call(InsertQuestionUsecaseParams(
      test: state.test,
      question: type == QuestionType.answer
          ? TextInputQuestionEntity(testId: state.test.id)
          : MultipleChoiceQuestionEntity(testId: state.test.id, options: const [
              MultipleChoiceOptionEntity(text: null),
              MultipleChoiceOptionEntity(text: null),
            ]),
      index: index + 1,
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
          test: r.test,
          currentQuestionIndex: index + 1)),
    );
  }

  Future<void> addAnotherRowOfOptions({
    required int questionIndex,
  }) async {
    final question = state.currentQuestion as MultipleChoiceQuestionEntity;
    if (question.options.length >= 4) {
      //TODO error message
      return;
    }
    emit(state.copyWith(status: TestEditorStatus.loading, failure: null));

    final response =
        await updateQuestionUsecase.call(UpdateQuestionUsecaseParams(
      test: state.test,
      replacementQuestion: MultipleChoiceQuestionEntity(
          testId: question.testId,
          image: question.image,
          options: [
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
      (r) => emit(state.copyWith(
          failure: null,
          status: TestEditorStatus.loaded,
          test: r.testEntity,
          currentQuestionIndex: index)),
    );
  }

  Future<void> updateCurrentQuestionOption(
      {required int optionIndex,
      required MultipleChoiceOptionEntity newOption}) async {
    final question = state.currentQuestion;
    if (question is! MultipleChoiceQuestionEntity) return;
    final options = question.options.toList();
    options[optionIndex] = newOption;
    await updateQuestion(
        index: state.currentQuestionIndex,
        replacementQuestion: question.copyWith(options: options));
  }

  Future<void> updateCurrentQuestionText({required String? newText}) async {
    updateQuestion(
      index: state.currentQuestionIndex,
      replacementQuestion: state.currentQuestion.copyWith(
        text: newText,
      ),
    );
  }
}
