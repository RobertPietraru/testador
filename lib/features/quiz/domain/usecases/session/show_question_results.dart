import 'package:dartz/dartz.dart';
import '../../../../../core/classes/usecase.dart';
import '../../failures/quiz_failures.dart';
import '../../repositories/quiz_repository.dart';

class ShowQuestionResultsUsecase extends UseCase<
    ShowQuestionResultsUsecaseResult, ShowQuestionResultsUsecaseParams> {
  const ShowQuestionResultsUsecase(this.quizRepository);
  final QuizRepository quizRepository;
  @override
  Future<Either<QuizFailure, ShowQuestionResultsUsecaseResult>> call(
      params) async {
    return quizRepository.showQuestionResults(params);
  }
}

class ShowQuestionResultsUsecaseParams extends Params {
  const ShowQuestionResultsUsecaseParams();
}

class ShowQuestionResultsUsecaseResult extends Response {
  const ShowQuestionResultsUsecaseResult();
}
