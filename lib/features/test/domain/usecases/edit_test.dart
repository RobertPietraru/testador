import 'package:dartz/dartz.dart';
import 'package:testador/features/test/domain/entities/question_entity.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
import '../../../../core/classes/usecase.dart';
import '../failures/test_failures.dart';
import '../repositories/test_repository.dart';

class EditTestUsecase
    extends UseCase<EditTestUsecaseResult, EditTestUsecaseParams> {
  const EditTestUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, EditTestUsecaseResult>> call(params) async {
    return testRepository.editTest(params);
  }
}

class EditTestUsecaseParams extends Params {
  final String testId;
  final TestEntity test;

  const EditTestUsecaseParams({required this.testId, required this.test});
}

class EditTestUsecaseResult extends Response {
  final TestEntity test;
  const EditTestUsecaseResult({required this.test});
}
