import '../../entities/test_entity.dart';
import '../../failures/test_failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/classes/usecase.dart';
import '../../repositories/test_repository.dart';
import 'package:testador/features/test/domain/entities/draft_entity.dart';

class DeleteQuestionUsecase
    extends UseCase<DeleteQuestionUsecaseResult, DeleteQuestionUsecaseParams> {
  const DeleteQuestionUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, DeleteQuestionUsecaseResult>> call(params) async {
    return testRepository.deleteQuestion(params);
  }
}

class DeleteQuestionUsecaseParams extends Params {
  final DraftEntity test;
  final int index;
  const DeleteQuestionUsecaseParams({required this.test, required this.index});
}

class DeleteQuestionUsecaseResult extends Response {
  final DraftEntity testEntity;
  const DeleteQuestionUsecaseResult({required this.testEntity});
}
