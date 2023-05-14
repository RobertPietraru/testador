part of 'quiz_retrival_cubit.dart';

abstract class QuizRetrivalState extends Equatable {
  const QuizRetrivalState();

  @override
  List<Object> get props => [];
}

class QuizRetrivalLoading extends QuizRetrivalState {}

class QuizRetrivalFailed extends QuizRetrivalState {}

class QuizRetrivalSuccessful extends QuizRetrivalState {
  final QuizEntity entity;

  const QuizRetrivalSuccessful({required this.entity});
  @override
  List<Object> get props => [entity];
}
