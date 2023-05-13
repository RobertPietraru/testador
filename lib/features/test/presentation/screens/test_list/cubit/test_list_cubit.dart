import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
import 'package:testador/features/test/domain/failures/test_failures.dart';
import 'package:testador/features/test/domain/usecases/test_usecases.dart';

part 'test_list_state.dart';

class TestListCubit extends Cubit<TestListState> {
  final CreateTestUsecase createTestUsecase;
  final GetTestsUsecase getTestsUsecase;

  TestListCubit(this.createTestUsecase, this.getTestsUsecase)
      : super(const TestListLoading(tests: []));

  void getTests({required String creatorId}) async {
    final response =
        await getTestsUsecase.call(GetTestsUsecaseParams(creatorId: creatorId));
    response.fold((failure) {
      emit(TestListError(tests: state.tests, failure: failure));
    }, (result) {
      result.testEntities.isEmpty
          ? emit(const TestListEmpty())
          : emit(TestListRetrieved(tests: result.testEntities));
    });
  }

  void createTest({required String creatorId}) async {
    final response = await createTestUsecase
        .call(CreateTestUsecaseParams(creatorId: creatorId));
    response.fold(
        (failure) => emit(TestListError(tests: state.tests, failure: failure)),
        (r) => emit(TestListCreatedTest(
            createdTest: r.testEntity, tests: [r.testEntity, ...state.tests])));
  }

  void updateTest({required TestEntity oldTest, required TestEntity newTest}) {
    final tests = state.tests.toList();
    final tests2 = state.tests.toList();
    final index = tests.indexWhere((element) => element.id == oldTest.id);
    tests[index] = newTest;
    emit(TestListRetrieved(tests: tests));
  }
}
