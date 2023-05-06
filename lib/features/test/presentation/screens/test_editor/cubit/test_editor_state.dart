part of 'test_editor_cubit.dart';

class TestEditorState extends Equatable {
  final TestEntity lastSavedTest;
  final TestEntity currentTest;
  final List<QuestionEntity> questions;
  final TestFailure? failure;

  const TestEditorState({
    required this.lastSavedTest,
    required this.currentTest,
    required this.questions,
    this.failure,
  });

  TestEditorState copyWith(
      TestEntity? lastSavedTest,
      TestEntity? currentTest,
      List<QuestionEntity>? questions,
      TestFailure? failure,
      {bool updateError = false}) {
    return TestEditorState(
      lastSavedTest: lastSavedTest ?? this.lastSavedTest,
      currentTest: currentTest ?? this.currentTest,
      questions: questions ?? this.questions,
      failure: updateError ? failure : this.failure,
    );
  }

  @override
  List<Object?> get props => [lastSavedTest, currentTest, questions, failure];
}
