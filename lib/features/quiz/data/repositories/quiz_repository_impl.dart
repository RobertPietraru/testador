import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:testador/features/quiz/data/datasources/quiz_local_datasource.dart';
import 'package:testador/features/quiz/data/datasources/quiz_remote_datasource.dart';
import 'package:testador/features/quiz/domain/failures/quiz_failures.dart';
import 'package:testador/features/quiz/domain/usecases/draft/delete_draft_by_id.dart';
import 'package:testador/features/quiz/domain/usecases/quiz_usecases.dart';
import '../../domain/repositories/quiz_repository.dart';

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
  Future<Either<QuizFailure, GetQuizesUsecaseResult>> getQuizes(
      GetQuizesUsecaseParams params) async {
    try {
      final quizes = await quizRemoteDataSource.getQuizes(params);
      final drafts = await quizLocalDataSource.getDrafts(params);

      return Right(GetQuizesUsecaseResult(
          pairs: quizes.map((quiz) {
        final index = drafts.indexWhere((draft) => draft.id == quiz.id);

        return QuizDraftPair(
            quiz: quiz, draft: index == -1 ? null : drafts[index]);
      }).toList()));
    } on FirebaseException catch (e) {
      return Left(QuizUnknownFailure(code: e.code));
    } on QuizFailure catch (error) {
      return Left(error);
    } on Error catch (_) {
      print(_.stackTrace);

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

  @override
  Future<Either<QuizFailure, BeginSessionUsecaseResult>> beginSession(
      BeginSessionUsecaseParams params) {
    // TODO: implement beginSession
    throw UnimplementedError();
  }

  @override
  Future<Either<QuizFailure, CreateSessionUsecaseResult>> createSession(
      CreateSessionUsecaseParams params) {
    // TODO: implement createSession
    throw UnimplementedError();
  }

  @override
  Future<Either<QuizFailure, EndSessionUsecaseResult>> endSession(
      EndSessionUsecaseParams params) {
    // TODO: implement endSession
    throw UnimplementedError();
  }

  @override
  Future<Either<QuizFailure, GoToNextQuestionUsecaseResult>> goToNextQuestion(
      GoToNextQuestionUsecaseParams params) {
    // TODO: implement goToNextQuestion
    throw UnimplementedError();
  }

  @override
  Future<Either<QuizFailure, JoinAsViewerUsecaseResult>> joinAsViewer(
      JoinAsViewerUsecaseParams params) {
    // TODO: implement joinAsViewer
    throw UnimplementedError();
  }

  @override
  Future<Either<QuizFailure, JoinSessionUsecaseResult>> joinSession(
      JoinSessionUsecaseParams params) {
    // TODO: implement joinSession
    throw UnimplementedError();
  }

  @override
  Future<Either<QuizFailure, KickFromSessionUsecaseResult>> kickFromSession(
      KickFromSessionUsecaseParams params) {
    // TODO: implement kickFromSession
    throw UnimplementedError();
  }

  @override
  Future<Either<QuizFailure, LeaveSessionUsecaseResult>> leaveSession(
      LeaveSessionUsecaseParams params) {
    // TODO: implement leaveSession
    throw UnimplementedError();
  }

  @override
  Future<Either<QuizFailure, SendAnswerUsecaseResult>> sendAnswer(
      SendAnswerUsecaseParams params) {
    // TODO: implement sendAnswer
    throw UnimplementedError();
  }

  @override
  Future<Either<QuizFailure, ShowPodiumUsecaseResult>> showPodium(
      ShowPodiumUsecaseParams params) {
    // TODO: implement showPodium
    throw UnimplementedError();
  }

  @override
  Future<Either<QuizFailure, ShowQuestionResultsUsecaseResult>>
      showQuestionResults(ShowQuestionResultsUsecaseParams params) {
    // TODO: implement showQuestionResults
    throw UnimplementedError();
  }
}
