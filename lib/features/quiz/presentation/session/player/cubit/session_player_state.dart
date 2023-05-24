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
      return SessionPlayerInGame(
        name: state.name,
        userId: state.userId,
        failure: state.failure,
        session: session,
      );
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

  const SessionPlayerInGame(
      {required this.userId,
      required this.name,
      this.failure,
      required this.session});

  @override
  List<Object?> get props => [userId, name, failure, session];
}
