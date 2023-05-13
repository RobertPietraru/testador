part of 'test_list_cubit.dart';

abstract class QuizListState extends Equatable {
  final List<QuizDraftPair> pairs;

  const QuizListState({required this.pairs});

  @override
  List<Object> get props => [pairs];
}

class QuizListLoading extends QuizListState {
  const QuizListLoading({required super.pairs});
}

class QuizListRetrieved extends QuizListState {
  const QuizListRetrieved({required super.pairs});
}

class QuizListCreatedDraft extends QuizListState {
  final DraftEntity createdDraft;
  const QuizListCreatedDraft({
    required super.pairs,
    required this.createdDraft,
  });
  @override
  List<Object> get props => [createdDraft, ...super.props];
}

class QuizListError extends QuizListState {
  final QuizFailure failure;

  const QuizListError({required super.pairs, required this.failure});
  @override
  List<Object> get props => [failure, ...super.props];
}

class QuizListEmpty extends QuizListState {
  const QuizListEmpty({super.pairs = const []});
}
