import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/features/quiz/domain/entities/quiz_entity.dart';
import 'package:testador/features/quiz/domain/usecases/quiz_usecases.dart';

part 'quiz_retrival_state.dart';

class QuizRetrivalCubit extends Cubit<QuizRetrivalState> {
  final GetQuizByIdUsecase getQuizByIdUsecase;

  QuizRetrivalCubit(this.getQuizByIdUsecase) : super(QuizRetrivalLoading());

  void initialize(
      {required QuizEntity? quizEntity, required String quizId}) async {
    if (quizEntity != null) {
      emit(QuizRetrivalSuccessful(entity: quizEntity));
      return;
    }
    final response =
        await getQuizByIdUsecase.call(GetQuizByIdUsecaseParams(quizId: quizId));

    response.fold(
      (l) => emit(QuizRetrivalFailed()),
      (r) => emit(QuizRetrivalSuccessful(entity: r.quizEntity)),
    );
  }
}
