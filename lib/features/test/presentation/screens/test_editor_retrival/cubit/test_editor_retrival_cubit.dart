import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
import 'package:testador/features/test/domain/usecases/test_usecases.dart';

part 'test_editor_retrival_state.dart';

class TestEditorRetrivalCubit extends Cubit<TestEditorRetrivalState> {
  final GetTestByIdUsecase getTestByIdUsecase;

  TestEditorRetrivalCubit(this.getTestByIdUsecase)
      : super(TestEditorRetrivalLoading());

  void initialize(
      {required TestEntity? testEntity, required String testId}) async {
    if (testEntity != null) {
      emit(TestEditorRetrivalSuccessful(entity: testEntity));
      return;
    }
    final response =
        await getTestByIdUsecase.call(GetTestByIdUsecaseParams(testId: testId));

    response.fold(
      (l) => emit(TestEditorRetrivalFailed()),
      (r) => emit(TestEditorRetrivalSuccessful(entity: r.testEntity)),
    );
  }
}
