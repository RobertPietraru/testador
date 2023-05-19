import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:testador/features/quiz/data/dtos/draft/draft_dto.dart';
import 'package:testador/features/quiz/data/dtos/quiz/quiz_dto.dart';
import 'package:testador/features/quiz/data/dtos/session/player_dto.dart';
import 'package:testador/features/quiz/data/dtos/session/session_dto.dart';
import 'package:testador/features/quiz/domain/entities/quiz_entity.dart';
import 'package:testador/features/quiz/domain/entities/session/session_entity.dart';
import 'package:testador/features/quiz/domain/failures/quiz_failures.dart';
import 'package:testador/features/quiz/domain/failures/session/player_name_already_in_use_failure.dart';

import '../../domain/usecases/quiz_usecases.dart';

const maxTriesForCodeCollision = 4;

abstract class QuizRemoteDataSource {
  Future<void> syncToDatabase(SyncQuizUsecaseParams params);
  Future<QuizEntity> getQuizById(GetQuizByIdUsecaseParams params);
  Future<List<QuizEntity>> getQuizes(GetQuizesUsecaseParams params);

  Future<ShowQuestionResultsUsecaseResult> showQuestionResults(
      ShowQuestionResultsUsecaseParams params);
  Future<ShowPodiumUsecaseResult> showPodium(ShowPodiumUsecaseParams params);
  Future<SendAnswerUsecaseResult> sendAnswer(SendAnswerUsecaseParams params);
  Future<LeaveSessionUsecaseResult> leaveSession(
      LeaveSessionUsecaseParams params);
  Future<KickFromSessionUsecaseResult> kickFromSession(
      KickFromSessionUsecaseParams params);
  Future<JoinSessionUsecaseResult> joinSession(JoinSessionUsecaseParams params);
  Future<JoinAsViewerUsecaseResult> joinAsViewer(
      JoinAsViewerUsecaseParams params);
  Future<GoToNextQuestionUsecaseResult> goToNextQuestion(
      GoToNextQuestionUsecaseParams params);
  Future<EndSessionUsecaseResult> endSession(EndSessionUsecaseParams params);
  Future<CreateSessionUsecaseResult> createSession(
      CreateSessionUsecaseParams params);
  Future<BeginSessionUsecaseResult> beginSession(
      BeginSessionUsecaseParams params);
}

class QuizRemoteDataSourceIMPL implements QuizRemoteDataSource {
  final random = Random.secure();
  final firestore = FirebaseFirestore.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  @override
  Future<void> syncToDatabase(SyncQuizUsecaseParams params) async {
    final quiz = DraftDto.fromEntity(params.draft);

    await firestore.collection('quizes').doc(quiz.id).set(quiz.toMap());
  }

  @override
  Future<QuizEntity> getQuizById(GetQuizByIdUsecaseParams params) {
    throw UnimplementedError();
  }

  @override
  Future<List<QuizEntity>> getQuizes(GetQuizesUsecaseParams params) async {
    final snap = await firestore
        .collection(QuizDto.collection)
        .where(QuizDto.creatorField, isEqualTo: params.creatorId)
        .get();
    return snap.docs.map((e) => QuizDto.fromMap(e.data()).toEntity()).toList();
  }

  @override
  Future<BeginSessionUsecaseResult> beginSession(
      BeginSessionUsecaseParams params) {
    throw UnimplementedError();
  }

  /// return null means max tries were reached and it's still colliding
  Future<String?> createCodeWithoutCollision(
      {required DatabaseReference sessions}) async {
    var id = generateQuizCode(7);
    for (var i = 0; i < maxTriesForCodeCollision; i++) {
      final session = await sessions.child(id).get();
      if (session.exists) {
        id = generateQuizCode(7);
      } else {
        return id;
      }
    }
    return null;
  }

  @override
  Future<CreateSessionUsecaseResult> createSession(
      CreateSessionUsecaseParams params) async {
    final sessions = ref.child('sessions');
    final code = await createCodeWithoutCollision(sessions: sessions);

    if (code == null) {
      throw const QuizUnknownFailure(code: 'quiz-code-collision');
    }

    final session = SessionDto(
      id: code,
      quizId: params.quiz.id,
      students: const [],
      currentQuestionId: params.quiz.questions.first.id,
      leaderboard: const [],
      answers: const [],
      status: SessionStatus.waitingForPlayers,
    );
    await ref.child('sessions').child(code).set(session.toMap());

    return CreateSessionUsecaseResult(session: session.toEntity());
  }

  String generateQuizCode(int codeLength) =>
      List.generate(codeLength, (index) => random.nextInt(10)).join();

  @override
  Future<EndSessionUsecaseResult> endSession(EndSessionUsecaseParams params) {
    // TODO: implement endSess    ion
    throw UnimplementedError();
  }

  @override
  Future<GoToNextQuestionUsecaseResult> goToNextQuestion(
      GoToNextQuestionUsecaseParams params) {
    // TODO: implement goToNextQuestion
    throw UnimplementedError();
  }

  @override
  Future<JoinAsViewerUsecaseResult> joinAsViewer(
      JoinAsViewerUsecaseParams params) {
    // TODO: implement joinAsViewer
    throw UnimplementedError();
  }

  @override
  Future<JoinSessionUsecaseResult> joinSession(
      JoinSessionUsecaseParams params) async {
    final sessionSnapshot =
        await ref.child('sessions').child(params.sessionId).get();
    final data = sessionSnapshot.value as Map<String, dynamic>;
    final session = SessionDto.fromMap(data, params.sessionId);
    final nameAlreadyUsed =
        session.students.indexWhere((element) => element.name == params.name) !=
            -1;

    if (nameAlreadyUsed) throw PlayerNameAlreadyInUseQuizFailure();
    final students = session.students.toList();
    students.add(PlayerDto(userId: params.userId, name: params.name));
    final newSession = session.copyWith(students: students);

    await ref.child('sessions').child(newSession.id).set(newSession.toMap());

    return JoinSessionUsecaseResult(session: newSession.toEntity());
  }

  @override
  Future<KickFromSessionUsecaseResult> kickFromSession(
      KickFromSessionUsecaseParams params) async {
    final sessionSnapshot =
        await ref.child('sessions').child(params.sessionId).get();
    final data = sessionSnapshot.value as Map<String, dynamic>;
    final session = SessionDto.fromMap(data, params.sessionId);
    final indexOfUser = session.students
        .indexWhere((element) => element.userId == params.userId);
    late SessionDto newSession;

    if (indexOfUser != -1) {
      final students = session.students.toList();
      students.removeAt(indexOfUser);
      newSession = session.copyWith(students: students);

      await ref.child('sessions').child(newSession.id).set(newSession.toMap());
    } else {
      newSession = session;
    }

    return KickFromSessionUsecaseResult(session: newSession.toEntity());
  }

  @override
  Future<LeaveSessionUsecaseResult> leaveSession(
      LeaveSessionUsecaseParams params) async {
    final sessionSnapshot =
        await ref.child('sessions').child(params.sessionId).get();
    final data = sessionSnapshot.value as Map<String, dynamic>;
    final session = SessionDto.fromMap(data, params.sessionId);
    final indexOfUser = session.students
        .indexWhere((element) => element.userId == params.userId);
    late SessionDto newSession;
    if (indexOfUser != -1) {
      final students = session.students.toList();
      students.removeAt(indexOfUser);
      newSession = session.copyWith(students: students);

      await ref.child('sessions').child(newSession.id).set(newSession.toMap());
    } else {
      newSession = session;
    }

    return LeaveSessionUsecaseResult(session: newSession.toEntity());
  }

  @override
  Future<SendAnswerUsecaseResult> sendAnswer(SendAnswerUsecaseParams params) {
    // TODO: implement sendAnswer
    throw UnimplementedError();
  }

  @override
  Future<ShowPodiumUsecaseResult> showPodium(ShowPodiumUsecaseParams params) {
    // TODO: implement showPodium
    throw UnimplementedError();
  }

  @override
  Future<ShowQuestionResultsUsecaseResult> showQuestionResults(
      ShowQuestionResultsUsecaseParams params) {
    // TODO: implement showQuestionResults
    throw UnimplementedError();
  }
}
