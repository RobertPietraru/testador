import 'package:dartz/dartz.dart';
import 'package:testador/features/quiz/domain/usecases/draft/delete_draft_by_id.dart';

import '../failures/quiz_failures.dart';
import '../usecases/quiz_usecases.dart';

abstract class QuizRepository {
  Future<Either<QuizFailure, GetDraftByIdUsecaseResult>> getDraftById(
      GetDraftByIdUsecaseParams params);
  Future<Either<QuizFailure, GetQuizByIdUsecaseResult>> getQuizById(
      GetQuizByIdUsecaseParams params);
  Future<Either<QuizFailure, GetQuizesUsecaseResult>> getQuizes(
      GetQuizesUsecaseParams params);
  Future<Either<QuizFailure, UpdateQuestionImageUsecaseResult>>
      updateQuestionImage(UpdateQuestionImageUsecaseParams params);
  Future<Either<QuizFailure, UpdateQuizImageUsecaseResult>> updateQuizImage(
      UpdateQuizImageUsecaseParams params);
  Future<Either<QuizFailure, SyncQuizUsecaseResult>> syncQuiz(
      SyncQuizUsecaseParams params);

  Future<Either<QuizFailure, CreateDraftUsecaseResult>> createQuiz(
      CreateDraftUsecaseParams params);
  Future<Either<QuizFailure, EditQuizUsecaseResult>> editQuiz(
      UpdateQuizUsecaseParams params);

  Future<Either<QuizFailure, MoveQuestionUsecaseResult>> moveQuestion(
      MoveQuestionUsecaseParams params);
  Future<Either<QuizFailure, InsertQuestionUsecaseResult>> insertQuestion(
      InsertQuestionUsecaseParams params);
  Future<Either<QuizFailure, DeleteQuestionUsecaseResult>> deleteQuestion(
      DeleteQuestionUsecaseParams params);
  Future<Either<QuizFailure, UpdateQuestionUsecaseResult>> updateQuestion(
      UpdateQuestionUsecaseParams params);

  Future<Either<QuizFailure, DeleteDraftByIdUsecaseResult>> deleteDraftById(
      DeleteDraftByIdUsecaseParams params);
}
