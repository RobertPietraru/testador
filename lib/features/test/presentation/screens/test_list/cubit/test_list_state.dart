part of 'test_list_cubit.dart';

abstract class TestListState extends Equatable {
  final List<TestEntity> tests;

  const TestListState({required this.tests});

  @override
  List<Object> get props => [tests];
}

class TestListLoading extends TestListState {
  const TestListLoading({required super.tests});
}

class TestListRetrieved extends TestListState {
  const TestListRetrieved({required super.tests});
}

class TestListCreatedDraft extends TestListState {
  final DraftEntity createdDraft;
  const TestListCreatedDraft({
    required super.tests,
    required this.createdDraft,
  });
  @override
  List<Object> get props => [createdDraft, ...super.props];
}

class TestListError extends TestListState {
  final TestFailure failure;

  const TestListError({required super.tests, required this.failure});
  @override
  List<Object> get props => [failure, ...super.props];
}

class TestListEmpty extends TestListState {
  const TestListEmpty({super.tests = const []});
}
