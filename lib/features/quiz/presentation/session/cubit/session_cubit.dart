import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/features/quiz/domain/entities/quiz_entity.dart';
import 'package:testador/features/quiz/domain/entities/session/session_entity.dart';
import 'package:testador/features/quiz/domain/failures/quiz_failures.dart';
import 'package:testador/features/quiz/domain/usecases/quiz_usecases.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final SubscribeToSessionUsecase subscribeToSessionUsecase;
  final CreateSessionUsecase createSessionUsecase;
  final JoinSessionUsecase joinSessionUsecase;
  final DeleteSessionUsecase deleteSessionUsecase;

  late final StreamSubscription<SessionEntity> sessionsStreamSubscription;

  SessionCubit(
    this.subscribeToSessionUsecase,
    this.createSessionUsecase,
    this.joinSessionUsecase,
    this.deleteSessionUsecase, {
    required QuizEntity quiz,
  }) : super(SessionLoadingState(quiz: quiz)) {
    createAndSubscribe();
  }

  Future<void> createAndSubscribe() async {
    final responseCreation = await createSessionUsecase.call(
        CreateSessionUsecaseParams(
            creatorId: state.quiz.creatorId, quiz: state.quiz));
    responseCreation.fold(
      (l) {
        emit(SessionFailureState(quiz: state.quiz, failure: l));
        return;
      },
      (r) async {
        emit(SessionInGameState(quiz: state.quiz, session: r.session));

        final responseSubscription = await subscribeToSessionUsecase
            .call(SubscribeToSessionUsecaseParams(sessionId: r.session.id));
        responseSubscription.fold(
          (failure) =>
              emit(SessionFailureState(quiz: state.quiz, failure: failure)),
          (r) => sessionsStreamSubscription = r.sessions.listen(
            (entity) {
              emit(SessionInGameState(quiz: state.quiz, session: entity));
            },
          ),
        );
      },
    );
  }

  Future<void> deleteAndUnsubscribe() async {
    if (this.state is SessionLoadingState) return;
    final state = this.state as SessionInGameState;
    final response = await deleteSessionUsecase
        .call(DeleteSessionUsecaseParams(session: state.session));
    // response.fold(
    //   (l) => emit(SessionInGameState(
    //       session: state.session, quiz: state.quiz, failure: l)),
    //   (r) => emit(SessionDeletedState(quiz: state.quiz)),
    // );

    sessionsStreamSubscription.cancel();
  }

  @override
  Future<void> close() {
    sessionsStreamSubscription.cancel();
    return super.close();
  }
}
