import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/features/test/domain/entities/draft_entity.dart';
import 'package:testador/features/test/domain/failures/test_failures.dart';
import 'package:testador/features/test/domain/usecases/test_usecases.dart';

part 'test_list_state.dart';

class TestListCubit extends Cubit<TestListState> {
  final CreateDraftUsecase createDraftUsecase;
  final GetDraftByIdUsecase getDraftByIdUsecase;
  final GetTestsUsecase getTestsUsecase;

  TestListCubit(
      this.createDraftUsecase, this.getTestsUsecase, this.getDraftByIdUsecase)
      : super(const TestListLoading(pairs: []));

  void getTests({required String creatorId}) async {
    final response =
        await getTestsUsecase.call(GetTestsUsecaseParams(creatorId: creatorId));
    response.fold((failure) {
      emit(TestListError(pairs: state.pairs, failure: failure));
    }, (result) {
      result.pairs.isEmpty
          ? emit(const TestListEmpty())
          : emit(TestListRetrieved(pairs: result.pairs));
    });
  }

  void createTest({required String creatorId}) async {
    final response = await createDraftUsecase
        .call(CreateDraftUsecaseParams(creatorId: creatorId));
    response.fold(
        (failure) => emit(TestListError(pairs: state.pairs, failure: failure)),
        (r) => emit(TestListCreatedDraft(createdDraft: r.draft, pairs: [
              TestDraftPair(test: r.draft.toTest(), draft: r.draft),
              ...state.pairs
            ])));
  }

  void updateTest({required DraftEntity draft}) {
    final pairs = state.pairs.toList();
    final index = pairs.indexWhere((pair) => pair.test.id == draft.id);
    pairs[index] = TestDraftPair(test: draft.toTest(), draft: draft);
    emit(TestListRetrieved(pairs: pairs));
  }

  void removeDraft(DraftEntity draft) {
    final index =
        state.pairs.indexWhere((element) => element.draft?.id == draft.id);
    if (index == -1) return;
    final pairs = state.pairs.toList();

    pairs[index] = TestDraftPair(test: pairs[index].test, draft: null);
    emit(TestListRetrieved(pairs: pairs));
  }
}