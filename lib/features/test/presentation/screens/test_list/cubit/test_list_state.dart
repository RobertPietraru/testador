part of 'test_list_cubit.dart';

abstract class TestListState extends Equatable {
  final List<TestDraftPair> pairs;

  const TestListState({required this.pairs});

  @override
  List<Object> get props => [pairs];
}

class TestListLoading extends TestListState {
  const TestListLoading({required super.pairs});
}

class TestListRetrieved extends TestListState {
  const TestListRetrieved({required super.pairs});
}

class TestListCreatedDraft extends TestListState {
  final DraftEntity createdDraft;
  const TestListCreatedDraft({
    required super.pairs,
    required this.createdDraft,
  });
  @override
  List<Object> get props => [createdDraft, ...super.props];
}

class TestListError extends TestListState {
  final TestFailure failure;

  const TestListError({required super.pairs, required this.failure});
  @override
  List<Object> get props => [failure, ...super.props];
}

class TestListEmpty extends TestListState {
  const TestListEmpty({super.pairs = const []});
}
