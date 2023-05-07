import 'package:testador/features/test/domain/entities/question_entity.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';

import '../failures/test_failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/classes/usecase.dart';
import '../repositories/test_repository.dart';

class UpdateQuestionUsecase
    extends UseCase<UpdateQuestionUsecaseResult, UpdateQuestionUsecaseParams> {
  const UpdateQuestionUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, UpdateQuestionUsecaseResult>> call(params) async {
    return testRepository.updateQuestion(params);
  }
}

class UpdateQuestionUsecaseParams extends Params {
  final TestEntity test;
  final QuestionEntity replacementQuestion;
  final int index;
  const UpdateQuestionUsecaseParams(
      {required this.test,
      required this.replacementQuestion,
      required this.index});
}

class UpdateQuestionUsecaseResult extends Response {
  final TestEntity testEntity;
  const UpdateQuestionUsecaseResult({required this.testEntity});
}
