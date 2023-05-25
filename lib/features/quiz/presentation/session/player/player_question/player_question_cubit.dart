import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/features/quiz/domain/entities/question_entity.dart';
import 'package:testador/features/quiz/domain/entities/session/session_entity.dart';
import 'package:testador/features/quiz/domain/usecases/quiz_usecases.dart';
import 'package:testador/features/quiz/presentation/session/timer/question_timer_cubit.dart';

part 'player_question_state.dart';

class PlayerQuestionCubit extends Cubit<PlayerQuestionState> {
  final SendAnswerUsecase sendAnswerUsecase;
  final QuestionTimerCubit timer;
  PlayerQuestionCubit(
    this.sendAnswerUsecase, {
    required this.timer,
    required SessionEntity session,
    required QuestionEntity question,
    required int questionindex,
  }) : super(
          PlayerQuestionState(
              session: session,
              status: PlayerQuestionStatus.thinking,
              question: question,
              selectedAnswerIndexes: const [],
              questionIndex: questionindex),
        );
  void ranOutOfTime() {}

  void sendAnswers() {}

  selectAnswer() {}
}
