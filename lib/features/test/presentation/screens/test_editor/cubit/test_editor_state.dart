part of 'test_editor_cubit.dart';

enum TestEditorStatus { loading, loaded, failed }

class TestEditorState extends Equatable {
  final TestEntity lastSavedTest;
  final TestEntity test;
  final TestFailure? failure;
  final TestEditorStatus status;
  final QuestionEntity currentQuestion;

  const TestEditorState({
    required this.currentQuestion,
    this.status = TestEditorStatus.loading,
    required this.lastSavedTest,
    required this.test,
    this.failure,
  });

  int get currentQuestionIndex => test.questions.indexOf(currentQuestion);

  TestEditorState copyWith(
      {TestEntity? lastSavedTest,
      TestEntity? test,
      TestFailure? failure,
      TestEditorStatus? status,
      QuestionEntity? currentQuestion,
      bool updateError = false}) {
    return TestEditorState(
      currentQuestion: currentQuestion ?? this.currentQuestion,
      status: status ?? this.status,
      lastSavedTest: lastSavedTest ?? this.lastSavedTest,
      test: test ?? this.test,
      failure: updateError ? failure : this.failure,
    );
  }

  @override
  List<Object?> get props =>
      [lastSavedTest, test, failure, status, currentQuestion];
}
