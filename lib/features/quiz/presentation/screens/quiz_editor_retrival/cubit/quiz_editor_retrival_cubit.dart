import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/features/quiz/domain/entities/quiz_entity.dart';
import 'package:testador/features/quiz/domain/usecases/quiz_usecases.dart';

part 'quiz_editor_retrival_state.dart';

class QuizEditorRetrivalCubit extends Cubit<QuizEditorRetrivalState> {
  final GetQuizByIdUsecase getQuizByIdUsecase;

  QuizEditorRetrivalCubit(this.getQuizByIdUsecase)
      : super(QuizEditorRetrivalLoading());

  void initialize(
      {required QuizEntity? quizEntity, required String quizId}) async {
    if (quizEntity != null) {
      emit(QuizEditorRetrivalSuccessful(entity: quizEntity));
      return;
    }
    final response =
        await getQuizByIdUsecase.call(GetQuizByIdUsecaseParams(quizId: quizId));

    response.fold(
      (l) => emit(QuizEditorRetrivalFailed()),
      (r) => emit(QuizEditorRetrivalSuccessful(entity: r.quizEntity)),
    );
  }
}
