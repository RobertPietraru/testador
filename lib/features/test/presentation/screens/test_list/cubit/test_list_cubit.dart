import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/features/test/domain/entities/draft_entity.dart';
import 'package:testador/features/test/domain/failures/test_failures.dart';
import 'package:testador/features/test/domain/usecases/test_usecases.dart';

part 'test_list_state.dart';

class QuizListCubit extends Cubit<QuizListState> {
  final CreateDraftUsecase createDraftUsecase;
  final GetDraftByIdUsecase getDraftByIdUsecase;
  final GetQuizsUsecase getQuizsUsecase;

  QuizListCubit(
      this.createDraftUsecase, this.getQuizsUsecase, this.getDraftByIdUsecase)
      : super(const QuizListLoading(pairs: []));

  void getQuizs({required String creatorId}) async {
    final response =
        await getQuizsUsecase.call(GetQuizsUsecaseParams(creatorId: creatorId));
    response.fold((failure) {
      emit(QuizListError(pairs: state.pairs, failure: failure));
    }, (result) {
      result.pairs.isEmpty
          ? emit(const QuizListEmpty())
          : emit(QuizListRetrieved(pairs: result.pairs));
    });
  }

  void createQuiz({required String creatorId}) async {
    final response = await createDraftUsecase
        .call(CreateDraftUsecaseParams(creatorId: creatorId));
    response.fold(
        (failure) => emit(QuizListError(pairs: state.pairs, failure: failure)),
        (r) => emit(QuizListCreatedDraft(createdDraft: r.draft, pairs: [
              QuizDraftPair(quiz: r.draft.toQuiz(), draft: r.draft),
              ...state.pairs
            ])));
  }

  void updateQuiz({required DraftEntity draft}) {
    final pairs = state.pairs.toList();
    final index = pairs.indexWhere((pair) => pair.quiz.id == draft.id);
    pairs[index] = QuizDraftPair(quiz: draft.toQuiz(), draft: draft);
    emit(QuizListRetrieved(pairs: pairs));
  }

  void removeDraft(DraftEntity draft) {
    final index =
        state.pairs.indexWhere((element) => element.draft?.id == draft.id);
    if (index == -1) return;
    final pairs = state.pairs.toList();

    pairs[index] = QuizDraftPair(quiz: pairs[index].quiz, draft: null);
    emit(QuizListRetrieved(pairs: pairs));
  }
}
