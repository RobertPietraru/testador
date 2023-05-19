import 'package:dartz/dartz.dart';
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
  const SendAnswerUsecaseParams();
}

class SendAnswerUsecaseResult extends Response {
  const SendAnswerUsecaseResult();
}
