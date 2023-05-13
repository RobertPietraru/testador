part of 'test_editor_cubit.dart';

enum TestEditorStatus { loading, loaded, failed }

class TestEditorState extends Equatable {
  final TestEntity lastSavedTest;
  final DraftEntity draft;
  final TestFailure? failure;
  final TestEditorStatus status;
  final int currentQuestionIndex;

  const TestEditorState({
    required this.currentQuestionIndex,
    this.status = TestEditorStatus.loading,
    required this.lastSavedTest,
    required this.draft,
    this.failure,
  });

  QuestionEntity get currentQuestion => draft.questions[currentQuestionIndex];

  bool get needsSync => draft.toTest() != lastSavedTest;

  TestEditorState copyWith(
      {TestEntity? lastSavedTest,
      DraftEntity? draft,
      TestFailure? failure,
      TestEditorStatus? status,
      int? currentQuestionIndex,
      bool updateError = false}) {
    return TestEditorState(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      status: status ?? this.status,
      lastSavedTest: lastSavedTest ?? this.lastSavedTest,
      draft: draft ?? this.draft,
      failure: updateError ? failure : this.failure,
    );
  }

  @override
  List<Object?> get props => [
        currentQuestionIndex,
        currentQuestion,
        lastSavedTest,
        draft,
        failure,
        status
      ];
}
