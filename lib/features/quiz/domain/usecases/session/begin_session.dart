import 'package:dartz/dartz.dart';
import '../../../../../core/classes/usecase.dart';
import '../../failures/quiz_failures.dart';
import '../../repositories/quiz_repository.dart';

class BeginSessionUsecase
    extends UseCase<BeginSessionUsecaseResult, BeginSessionUsecaseParams> {
  const BeginSessionUsecase(this.quizRepository);
  final QuizRepository quizRepository;
  @override
  Future<Either<QuizFailure, BeginSessionUsecaseResult>> call(params) async {
    return quizRepository.beginSession(params);
  }
}

class BeginSessionUsecaseParams extends Params {
  const BeginSessionUsecaseParams();
}

class BeginSessionUsecaseResult extends Response {
  const BeginSessionUsecaseResult();
}
