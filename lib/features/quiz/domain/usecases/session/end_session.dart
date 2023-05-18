import 'package:dartz/dartz.dart';
import '../../../../../core/classes/usecase.dart';
import '../../failures/quiz_failures.dart';
import '../../repositories/quiz_repository.dart';

class EndSessionUsecase
    extends UseCase<EndSessionUsecaseResult, EndSessionUsecaseParams> {
  const EndSessionUsecase(this.quizRepository);
  final QuizRepository quizRepository;
  @override
  Future<Either<QuizFailure, EndSessionUsecaseResult>> call(params) async {
    return quizRepository.endSession(params);
  }
}

class EndSessionUsecaseParams extends Params {
  const EndSessionUsecaseParams();
}

class EndSessionUsecaseResult extends Response {
  const EndSessionUsecaseResult();
}
