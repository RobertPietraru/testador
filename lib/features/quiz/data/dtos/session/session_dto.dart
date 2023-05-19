import 'package:equatable/equatable.dart';
import 'package:testador/features/quiz/data/dtos/session/player_dto.dart';
import 'package:testador/features/quiz/domain/entities/session/session_entity.dart';

import '../../../../../core/globals.dart';

extension Dto on SessionStatus {}

class SessionDto extends Equatable {
  final String id;
  final String quizId;
  final SessionStatus status;
  final List<PlayerDto> students;
  final String currentQuestionId;
  final List<PlayerDto> leaderboard;
  final List<SessionAnswerDto> answers;

  static const String quizIdField = 'quizId';
  static const String statusField = 'status';
  static const String studentsField = 'students';
  static const String currentQuestionIdField = 'currentQuestionId';
  static const String leaderboardField = 'leaderboard';
  static const String answersField = 'answers';

  const SessionDto({
    required this.id,
    required this.quizId,
    required this.students,
    required this.currentQuestionId,
    required this.leaderboard,
    required this.answers,
    required this.status,
  });

  @override
  List<Object> get props =>
      [id, quizId, students, currentQuestionId, leaderboard, answers, status];

  SessionDto copyWith({
    String? id,
    String? quizId,
    List<PlayerDto>? students,
    String? currentQuestionId,
    List<PlayerDto>? leaderboard,
    List<SessionAnswerDto>? answers,
    SessionStatus? status,
  }) {
    return SessionDto(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      students: students ?? this.students,
      currentQuestionId: currentQuestionId ?? this.currentQuestionId,
      leaderboard: leaderboard ?? this.leaderboard,
      answers: answers ?? this.answers,
      status: status ?? this.status,
    );
  }

  SessionEntity toEntity() {
    return SessionEntity(
      id: id,
      quizId: quizId,
      students: students.map((e) => e.toEntity(e)).toList(),
      currentQuestionId: currentQuestionId,
      leaderboard: leaderboard.map((e) => e.toEntity(e)).toList(),
      answers: answers.map((e) => e.toEntity()).toList(),
      status: status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      quizIdField: quizId,
      statusField: status.asString(),
      studentsField: students.map((e) => e.toMap()).toList(),
      currentQuestionIdField: currentQuestionId,
      leaderboardField: leaderboard.map((e) => e.toMap()).toList(),
      answersField: answers.map((e) => e.toMap()).toList(),
    };
  }

  factory SessionDto.fromMap(Map<String, dynamic> map, String id) {
    return SessionDto(
      id: id,
      quizId: map[quizIdField],
      students: (map[studentsField] as List<Map<String, dynamic>>)
          .map((e) => PlayerDto.fromMap(e))
          .toList(),
      currentQuestionId: map[currentQuestionIdField],
      leaderboard: (map[leaderboardField] as List<Map<String, dynamic>>)
          .map((e) => PlayerDto.fromMap(e))
          .toList(),
      answers: (map[answersField] as List<Map<String, dynamic>>)
          .map((e) => SessionAnswerDto.fromMap(e))
          .toList(),
      status: SessionStatus.fromString(map[statusField]),
    );
  }
}

class SessionAnswerDto extends Equatable {
  final String userId;
  final int? optionIndex;
  final String? answer;

  const SessionAnswerDto({required this.userId, this.optionIndex, this.answer});

  static const userIdField = 'userId';
  static const optionIndexField = 'optionIndex';
  static const answerField = 'answer';

  @override
  List<Object?> get props => [userId, optionIndex, answer];

  SessionAnswer toEntity() {
    return SessionAnswer(
        userId: userId, answer: answer, optionIndex: optionIndex);
  }

  Map<String, dynamic> toMap() {
    return {
      userIdField: userId,
      optionIndexField: optionIndex,
      answerField: answer,
    };
  }

  factory SessionAnswerDto.fromEntity(SessionAnswer entity) {
    return SessionAnswerDto(
      userId: entity.userId,
      answer: entity.answer,
      optionIndex: entity.optionIndex,
    );
  }

  factory SessionAnswerDto.fromMap(Map<String, dynamic> map) {
    return SessionAnswerDto(
      userId: map[userIdField],
      answer: map[optionIndexField],
      optionIndex: map[answerField],
    );
  }

  SessionAnswerDto copyWith({
    String? userId,
    int? optionIndex = DefaultValues.forInts,
    String? answer = DefaultValues.forStrings,
  }) {
    return SessionAnswerDto(
      userId: userId ?? this.userId,
      optionIndex: optionIndex ?? this.optionIndex,
      answer: answer ?? this.answer,
    );
  }
}
