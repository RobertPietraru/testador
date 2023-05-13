import 'package:testador/features/test/domain/entities/test_entity.dart';
import 'package:testador/features/test/domain/entities/draft_entity.dart';

import '../../failures/test_failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/classes/usecase.dart';
import '../../repositories/test_repository.dart';

class SyncQuizUsecase
    extends UseCase<SyncQuizUsecaseResult, SyncQuizUsecaseParams> {
  const SyncQuizUsecase(this.quizRepository);
  final QuizRepository quizRepository;
  @override
  Future<Either<QuizFailure, SyncQuizUsecaseResult>> call(params) async {
    return quizRepository.syncQuiz(params);
  }
}

class SyncQuizUsecaseParams extends Params {
  final DraftEntity draft;
  const SyncQuizUsecaseParams({required this.draft});
}

class SyncQuizUsecaseResult extends Response {
  const SyncQuizUsecaseResult();
}
