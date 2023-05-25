part of 'session_player_cubit.dart';

abstract class SessionPlayerState extends Equatable {
  const SessionPlayerState();
  SessionPlayerState withSession(SessionEntity session) {
    final state = this;
    if (state is SessionPlayerNameRetrival) {
      return SessionPlayerNameRetrival(
        isLoading: state.isLoading,
        name: state.name,
        userId: state.userId,
        session: session,
        failure: state.failure,
      );
    } else if (state is SessionPlayerInGame) {
      return state.copyWith(session: session);
    }
    return this;
  }
}

class SessionPlayerCodeRetrival extends SessionPlayerState {
  final String userId;
  final String sessionId;
  final bool isLoading;
  final QuizFailure? failure;

  const SessionPlayerCodeRetrival({
    required this.failure,
    required this.userId,
    required this.sessionId,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [userId, sessionId, isLoading, failure];
}

class SessionPlayerNameRetrival extends SessionPlayerState {
  final String userId;
  final String name;
  final QuizFailure? failure;
  final SessionEntity session;

  final bool isLoading;

  const SessionPlayerNameRetrival(
      {required this.name,
      required this.userId,
      this.failure,
      required this.session,
      required this.isLoading});

  @override
  List<Object?> get props => [userId, failure, name, session, isLoading];
}

class SessionPlayerInGame extends SessionPlayerState {
  final String userId;
  final String name;
  final SessionEntity session;
  final QuizFailure? failure;
  final QuizEntity quiz;
  final List<int> selectedAnswers;
  final bool isSent;

  const SessionPlayerInGame(
      {required this.userId,
      required this.isSent,
      required this.selectedAnswers,
      required this.quiz,
      required this.name,
      this.failure,
      required this.session});

  SessionPlayerInGame copyWith({
    String? userId,
    String? name,
    SessionEntity? session,
    QuizFailure? failure = const QuizUnknownFailure(code: 'mock'),
    QuizEntity? quiz,
    List<int>? selectedAnswers,
    bool? isSent,
  }) {
    return SessionPlayerInGame(
      userId: userId ?? this.userId,
      isSent: isSent ?? this.isSent,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      quiz: quiz ?? this.quiz,
      name: name ?? this.name,
      session: session ?? this.session,
      failure: failure == const QuizUnknownFailure(code: 'mock')
          ? this.failure
          : failure,
    );
  }

  @override
  List<Object?> get props =>
      [userId, name, isSent, failure, session, quiz, ...selectedAnswers];

  int get currentQuestionIndex => quiz.questions
      .indexWhere((element) => element.id == session.currentQuestionId);
  QuestionEntity get currentQuestion => quiz.questions[currentQuestionIndex];
}
