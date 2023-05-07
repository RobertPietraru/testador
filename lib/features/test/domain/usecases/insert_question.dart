import 'package:testador/features/test/domain/entities/question_entity.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';

import '../failures/test_failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/classes/usecase.dart';
import '../repositories/test_repository.dart';

class InsertQuestionUsecase
    extends UseCase<InsertQuestionUsecaseResult, InsertQuestionUsecaseParams> {
  const InsertQuestionUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, InsertQuestionUsecaseResult>> call(params) async {
    return testRepository.insertQuestion(params);
  }
}

class InsertQuestionUsecaseParams extends Params {
  final TestEntity test;
  final QuestionEntity question;
  final int index;
  const InsertQuestionUsecaseParams({
    required this.test,
    required this.question,
    required this.index,
  });
}

class InsertQuestionUsecaseResult extends Response {
  final TestEntity test;
  const InsertQuestionUsecaseResult({required this.test});
}
