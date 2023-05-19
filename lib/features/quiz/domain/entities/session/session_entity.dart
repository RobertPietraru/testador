import 'package:equatable/equatable.dart';
import 'package:testador/core/globals.dart';
import 'package:testador/features/quiz/domain/entities/session/player_entity.dart';

enum SessionStatus { waitingForPlayers, question, answers, leaderboard, podium }

class SessionEntity extends Equatable {
  final String id;
  final String quizId;
  final SessionStatus status;
  final List<PlayerEntity> students;
  final String currentQuestionId;
  final List<PlayerEntity> leaderboard;
  final List<SessionAnswer> answers;

  const SessionEntity({
    required this.id,
    required this.quizId,
    required this.students,
    required this.currentQuestionId,
    required this.leaderboard,
    required this.answers,
    required this.status,
  });

  @override
  List<Object> get props => [id, quizId, students, currentQuestionId, leaderboard, answers, status];


  SessionEntity copyWith({
    String? id,
    String? quizId,
    List<PlayerEntity>? students,
    String? currentQuestionId,
    List<PlayerEntity>? leaderboard,
    List<SessionAnswer>? answers,
    SessionStatus? status,
  }) {
    return SessionEntity(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      students: students ?? this.students,
      currentQuestionId: currentQuestionId ?? this.currentQuestionId,
      leaderboard: leaderboard ?? this.leaderboard,
      answers: answers ?? this.answers,
      status: status ?? this.status,
    );
  }
}

class SessionAnswer extends Equatable {
  final String userId;
  final int? optionIndex;
  final String? answer;

  const SessionAnswer({required this.userId, this.optionIndex, this.answer});

  @override
  List<Object?> get props => [userId, optionIndex, answer];

  SessionAnswer copyWith({
    String? userId,
    int? optionIndex = DefaultValues.forInts,
    String? answer = DefaultValues.forStrings,
  }) {
    return SessionAnswer(
      userId: userId ?? this.userId,
      optionIndex: optionIndex ?? this.optionIndex,
      answer: answer ?? this.answer,
    );
  }
}
