import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:testador/features/test/data/datasources/test_local_datasource.dart';
import 'package:testador/features/test/data/datasources/test_remote_datasource.dart';
import 'package:testador/features/test/domain/failures/test_failures.dart';
import 'package:testador/features/test/domain/usecases/draft/delete_draft_by_id.dart';
import 'package:testador/features/test/domain/usecases/test_usecases.dart';
import '../../domain/repositories/test_repository.dart';

class QuizRepositoryIMPL implements QuizRepository {
  const QuizRepositoryIMPL(
    this.quizLocalDataSource,
    this.quizRemoteDataSource,
  );

  final QuizLocalDataSource quizLocalDataSource;
  final QuizRemoteDataSource quizRemoteDataSource;

  @override
  Future<Either<QuizFailure, CreateDraftUsecaseResult>> createQuiz(
      CreateDraftUsecaseParams params) async {
    try {
      final quizEntity = await quizLocalDataSource.createDraft(params);
      return Right(CreateDraftUsecaseResult(draft: quizEntity));
    } on FirebaseException catch (e) {
      return Left(QuizUnknownFailure(code: e.code));
    } on QuizFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(QuizUnknownFailure());
    }
  }

  @override
  Future<Either<QuizFailure, DeleteQuestionUsecaseResult>> deleteQuestion(
      DeleteQuestionUsecaseParams params) async {
    try {
      final quizEntity = await quizLocalDataSource.deleteQuestion(params);
      return Right(DeleteQuestionUsecaseResult(quizEntity: quizEntity));
    } on FirebaseException catch (e) {
      return Left(QuizUnknownFailure(code: e.code));
    } on QuizFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(QuizUnknownFailure());
    }
  }

  @override
  Future<Either<QuizFailure, InsertQuestionUsecaseResult>> insertQuestion(
      InsertQuestionUsecaseParams params) async {
    try {
      final response = await quizLocalDataSource.insertQuestion(params);
      return Right(InsertQuestionUsecaseResult(draft: response));
    } on FirebaseException catch (e) {
      return Left(QuizUnknownFailure(code: e.code));
    } on QuizFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(QuizUnknownFailure());
    }
  }

  @override
  Future<Either<QuizFailure, UpdateQuestionUsecaseResult>> updateQuestion(
      UpdateQuestionUsecaseParams params) async {
    try {
      final quizEntity = await quizLocalDataSource.updateQuestion(params);
      return Right(UpdateQuestionUsecaseResult(quizEntity: quizEntity));
    } on FirebaseException catch (e) {
      return Left(QuizUnknownFailure(code: e.code));
    } on QuizFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(QuizUnknownFailure());
    }
  }

  @override
  Future<Either<QuizFailure, EditQuizUsecaseResult>> editQuiz(
      UpdateQuizUsecaseParams params) async {
    try {
      final quizEntity = await quizLocalDataSource.updateQuiz(params);
      return Right(EditQuizUsecaseResult(quiz: quizEntity));
    } on FirebaseException catch (e) {
      return Left(QuizUnknownFailure(code: e.code));
    } on QuizFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(QuizUnknownFailure());
    }
  }

  @override
  Future<Either<QuizFailure, GetQuizsUsecaseResult>> getQuizs(
      GetQuizsUsecaseParams params) async {
    try {
      final quizs = await quizRemoteDataSource.getQuizs(params);
      final drafts = await quizLocalDataSource.getDrafts(params);

      return Right(GetQuizsUsecaseResult(
          pairs: quizs.map((quiz) {
        final index = drafts.indexWhere((draft) => draft.id == quiz.id);

        return QuizDraftPair(
            quiz: quiz, draft: index == -1 ? null : drafts[index]);
      }).toList()));
    } on FirebaseException catch (e) {
      return Left(QuizUnknownFailure(code: e.code));
    } on QuizFailure catch (error) {
      return Left(error);
    } on Error catch (_) {
      return const Left(QuizUnknownFailure());
    }
  }

  @override
  Future<Either<QuizFailure, GetDraftByIdUsecaseResult>> getDraftById(
      GetDraftByIdUsecaseParams params) async {
    try {
      final quiz = await quizLocalDataSource.getDraftById(params);
      return Right(GetDraftByIdUsecaseResult(draft: quiz));
    } on FirebaseException catch (e) {
      return Left(QuizUnknownFailure(code: e.code));
    } on QuizFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(QuizUnknownFailure());
    }
  }

  @override
  Future<Either<QuizFailure, MoveQuestionUsecaseResult>> moveQuestion(
      MoveQuestionUsecaseParams params) async {
    try {
      final quiz = await quizLocalDataSource.moveQuestion(params);
      return Right(MoveQuestionUsecaseResult(quiz: quiz));
    } on FirebaseException catch (e) {
      return Left(QuizUnknownFailure(code: e.code));
    } on QuizFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(QuizUnknownFailure());
    }
  }

  @override
  Future<Either<QuizFailure, UpdateQuestionImageUsecaseResult>>
      updateQuestionImage(UpdateQuestionImageUsecaseParams params) async {
    try {
      final quiz = await quizLocalDataSource.updateQuestionImage(params);
      return Right(UpdateQuestionImageUsecaseResult(quiz: quiz));
    } on FirebaseException catch (e) {
      return Left(QuizUnknownFailure(code: e.code));
    } on QuizFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(QuizUnknownFailure());
    }
  }

  @override
  Future<Either<QuizFailure, UpdateQuizImageUsecaseResult>> updateQuizImage(
      UpdateQuizImageUsecaseParams params) async {
    try {
      final quiz = await quizLocalDataSource.updateQuizImage(params);
      return Right(UpdateQuizImageUsecaseResult(quiz: quiz));
    } on FirebaseException catch (e) {
      return Left(QuizUnknownFailure(code: e.code));
    } on QuizFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(QuizUnknownFailure());
    }
  }

  @override
  Future<Either<QuizFailure, SyncQuizUsecaseResult>> syncQuiz(
      SyncQuizUsecaseParams params) async {
    try {
      quizRemoteDataSource.syncToDatabase(params);
      return const Right(SyncQuizUsecaseResult());
    } on FirebaseException catch (e) {
      return Left(QuizUnknownFailure(code: e.code));
    } on QuizFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(QuizUnknownFailure());
    }
  }

  @override
  Future<Either<QuizFailure, GetQuizByIdUsecaseResult>> getQuizById(
      GetQuizByIdUsecaseParams params) async {
    try {
      final quiz = await quizRemoteDataSource.getQuizById(params);
      return Right(GetQuizByIdUsecaseResult(quizEntity: quiz));
    } on FirebaseException catch (e) {
      return Left(QuizUnknownFailure(code: e.code));
    } on QuizFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(QuizUnknownFailure());
    }
  }

  @override
  Future<Either<QuizFailure, DeleteDraftByIdUsecaseResult>> deleteDraftById(
      DeleteDraftByIdUsecaseParams params) async {
    try {
      await quizLocalDataSource.deleteDraftById(params);
      return const Right(DeleteDraftByIdUsecaseResult());
    } on FirebaseException catch (e) {
      return Left(QuizUnknownFailure(code: e.code));
    } on QuizFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(QuizUnknownFailure());
    }
  }
}
