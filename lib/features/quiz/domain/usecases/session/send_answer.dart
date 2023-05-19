import 'package:dartz/dartz.dart';
import 'package:testador/features/quiz/domain/entities/session/session_entity.dart';
import '../../../../../core/classes/usecase.dart';
import '../../failures/quiz_failures.dart';
import '../../repositories/quiz_repository.dart';

class SendAnswerUsecase
    extends UseCase<SendAnswerUsecaseResult, SendAnswerUsecaseParams> {
  const SendAnswerUsecase(this.quizRepository);
  final QuizRepository quizRepository;
  @override
  Future<Either<QuizFailure, SendAnswerUsecaseResult>> call(params) async {
    return quizRepository.sendAnswer(params);
  }
}

class SendAnswerUsecaseParams extends Params {
  final String sessionId;
  final String userId;
  final int? answerIndex;
  final String? answer;

  const SendAnswerUsecaseParams(
      {required this.sessionId,
      required this.userId,
      this.answerIndex,
      this.answer});
}

class SendAnswerUsecaseResult extends Response {
  final SessionEntity session;
  const SendAnswerUsecaseResult({required this.session});
}
