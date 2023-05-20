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
    required this.answers,
    required this.status,
  });

  @override
  List<Object> get props =>
      [id, quizId, students, currentQuestionId, answers, status];

  SessionDto copyWith({
    String? id,
    String? quizId,
    List<PlayerDto>? students,
    String? currentQuestionId,
    List<SessionAnswerDto>? answers,
    SessionStatus? status,
  }) {
    return SessionDto(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      students: students ?? this.students,
      currentQuestionId: currentQuestionId ?? this.currentQuestionId,
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
      answers: answers.map((e) => e.toEntity()).toList(),
      status: status,
    );
  }

  Map<dynamic, dynamic> toMap() {
    return {
      quizIdField: quizId,
      statusField: status.asString(),
      studentsField: students.map((e) => e.toMap()).toList(),
      currentQuestionIdField: currentQuestionId,
      answersField: answers.map((e) => e.toMap()).toList(),
    };
  }

  factory SessionDto.fromMap(Map<dynamic, dynamic> map, String id) {
    return SessionDto(
      id: id,
      quizId: map[quizIdField],
      students: ((map[studentsField] as List<Map<dynamic, dynamic>>?) ?? [])
          .map((e) => PlayerDto.fromMap(e))
          .toList(),
      currentQuestionId: map[currentQuestionIdField],
      answers: ((map[answersField] as List<Map<dynamic, dynamic>>?) ?? [])
          .map((e) => SessionAnswerDto.fromMap(e))
          .toList(),
      status: SessionStatus.fromString(map[statusField]),
    );
  }

  factory SessionDto.fromEntity(SessionEntity session) {
    return SessionDto(
      id: session.id,
      quizId: session.quizId,
      students: session.students.map((e) => PlayerDto.fromEntity(e)).toList(),
      currentQuestionId: session.currentQuestionId,
      answers:
          session.answers.map((e) => SessionAnswerDto.fromEntity(e)).toList(),
      status: session.status,
    );
  }
}

class SessionAnswerDto extends Equatable {
  final String userId;
  final int? optionIndex;
  final String? answer;
  final Duration responseTime;

  const SessionAnswerDto(
      {required this.userId,
      this.optionIndex,
      this.answer,
      required this.responseTime});

  static const userIdField = 'userId';
  static const optionIndexField = 'optionIndex';
  static const answerField = 'answer';
  static const responseTimeField = 'responseTime';

  @override
  List<Object?> get props => [userId, optionIndex, answer];

  SessionAnswer toEntity() {
    return SessionAnswer(
      userId: userId,
      answer: answer,
      optionIndex: optionIndex,
      responseTime: responseTime,
    );
  }

  Map<dynamic, dynamic> toMap() {
    return {
      userIdField: userId,
      optionIndexField: optionIndex,
      answerField: answer,
      responseTimeField: responseTime,
    };
  }

  factory SessionAnswerDto.fromEntity(SessionAnswer entity) {
    return SessionAnswerDto(
      responseTime: entity.responseTime,
      userId: entity.userId,
      answer: entity.answer,
      optionIndex: entity.optionIndex,
    );
  }

  factory SessionAnswerDto.fromMap(Map<dynamic, dynamic> map) {
    return SessionAnswerDto(
      userId: map[userIdField],
      answer: map[optionIndexField],
      optionIndex: map[answerField],
      responseTime: map[responseTimeField],
    );
  }

  SessionAnswerDto copyWith({
    String? userId,
    int? optionIndex = DefaultValues.forInts,
    String? answer = DefaultValues.forStrings,
    Duration? responseTime,
  }) {
    return SessionAnswerDto(
      userId: userId ?? this.userId,
      optionIndex: optionIndex ?? this.optionIndex,
      answer: answer ?? this.answer,
      responseTime: responseTime ?? this.responseTime,
    );
  }
}
