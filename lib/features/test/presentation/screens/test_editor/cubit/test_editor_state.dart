part of 'test_editor_cubit.dart';

enum TestEditorStatus { loading, loaded, failed }

class TestEditorState extends Equatable {
  final TestEntity lastSavedTest;
  final TestEntity test;
  final TestFailure? failure;
  final TestEditorStatus status;
  final int currentQuestionIndex;

  const TestEditorState({
    required this.currentQuestionIndex,
    this.status = TestEditorStatus.loading,
    required this.lastSavedTest,
    required this.test,
    this.failure,
  });

  QuestionEntity get currentQuestion => test.questions[currentQuestionIndex];

  TestEditorState copyWith(
      {TestEntity? lastSavedTest,
      TestEntity? test,
      TestFailure? failure,
      TestEditorStatus? status,
      int? currentQuestionIndex,
      bool updateError = false}) {
    return TestEditorState(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      status: status ?? this.status,
      lastSavedTest: lastSavedTest ?? this.lastSavedTest,
      test: test ?? this.test,
      failure: updateError ? failure : this.failure,
    );
  }

  @override
  List<Object?> get props => [
        currentQuestionIndex,
        currentQuestion,
        lastSavedTest,
        test,
        failure,
        status
      ];
}
