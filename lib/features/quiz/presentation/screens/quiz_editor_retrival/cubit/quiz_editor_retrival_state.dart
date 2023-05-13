part of 'quiz_editor_retrival_cubit.dart';

abstract class QuizEditorRetrivalState extends Equatable {
  const QuizEditorRetrivalState();

  @override
  List<Object> get props => [];
}

class QuizEditorRetrivalLoading extends QuizEditorRetrivalState {}

class QuizEditorRetrivalFailed extends QuizEditorRetrivalState {}

class QuizEditorRetrivalSuccessful extends QuizEditorRetrivalState {
  final QuizEntity entity;

  const QuizEditorRetrivalSuccessful({required this.entity});
  @override
  List<Object> get props => [entity];
}
