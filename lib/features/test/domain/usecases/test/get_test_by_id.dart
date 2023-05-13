import '../../../../../core/classes/usecase.dart';
import '../../entities/test_entity.dart';
import '../../failures/test_failures.dart';
import '../../repositories/test_repository.dart';

import 'package:dartz/dartz.dart';

class GetQuizByIdUsecase
    extends UseCase<GetQuizByIdUsecaseResult, GetQuizByIdUsecaseParams> {
  const GetQuizByIdUsecase(this.quizRepository);
  final QuizRepository quizRepository;
  @override
  Future<Either<QuizFailure, GetQuizByIdUsecaseResult>> call(params) async {
    return quizRepository.getQuizById(params);
  }
}

class GetQuizByIdUsecaseParams extends Params {
  final String quizId;
  const GetQuizByIdUsecaseParams({required this.quizId});
}

class GetQuizByIdUsecaseResult extends Response {
  final QuizEntity quizEntity;
  const GetQuizByIdUsecaseResult({required this.quizEntity});
}
