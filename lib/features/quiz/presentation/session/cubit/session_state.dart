part of 'session_cubit.dart';

abstract class SessionState extends Equatable {
  final QuizEntity quiz;
  const SessionState({required this.quiz});
}

class SessionInGameState extends SessionState {
  final SessionEntity session;
  final QuizFailure? failure;
  const SessionInGameState(
      {required super.quiz, required this.session, this.failure});

  @override
  List<Object?> get props => [quiz, session, failure];
  SessionInGameState copyWith({
    QuizEntity? quiz,
    SessionEntity? session,
    QuizFailure? failure = const QuizUnknownFailure(code: 'fake-error'),
  }) {
    return SessionInGameState(
      quiz: quiz ?? this.quiz,
      session: session ?? this.session,
      failure: failure == const QuizUnknownFailure(code: 'fake-error')
          ? this.failure
          : failure,
    );
  }
}

class SessionLoadingState extends SessionState {
  const SessionLoadingState({required super.quiz});

  @override
  List<Object?> get props => [quiz];
}

class SessionFailureState extends SessionState {
  final QuizFailure failure;
  const SessionFailureState({required super.quiz, required this.failure});

  @override
  List<Object?> get props => [quiz, failure];
}

class SessionDeletedState extends SessionState {
  const SessionDeletedState({required super.quiz});

  @override
  List<Object?> get props => [quiz];
}
