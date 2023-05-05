part of 'test_list_cubit.dart';

abstract class TestListState extends Equatable {
  final List<TestEntity> tests;

  const TestListState({required this.tests});

  @override
  List<Object> get props => [];
}

class TestListLoading extends TestListState {
  const TestListLoading({required super.tests});
}

class TestListRetrieved extends TestListState {
  const TestListRetrieved({required super.tests});
}

class TestListError extends TestListState {
  final TestFailure failure;

  const TestListError({required super.tests, required this.failure});
}

class TestListEmpty extends TestListState {
  const TestListEmpty({super.tests = const []});
}
