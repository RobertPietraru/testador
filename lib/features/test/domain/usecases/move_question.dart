import 'package:testador/features/test/domain/entities/question_entity.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';

import '../failures/test_failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/classes/usecase.dart';
import '../repositories/test_repository.dart';

class MoveQuestionUsecase
    extends UseCase<MoveQuestionUsecaseResult, MoveQuestionUsecaseParams> {
  const MoveQuestionUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, MoveQuestionUsecaseResult>> call(params) async {
    return testRepository.moveQuestion(params);
  }
}

class MoveQuestionUsecaseParams extends Params {
  final TestEntity test;
  final int oldIndex;
  final int newIndex;
  const MoveQuestionUsecaseParams({
    required this.oldIndex,
    required this.newIndex,
    required this.test,
  });
}

class MoveQuestionUsecaseResult extends Response {
  final TestEntity test;
  const MoveQuestionUsecaseResult({required this.test});
}
