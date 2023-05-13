import 'package:dartz/dartz.dart';
import 'package:testador/features/test/domain/entities/draft_entity.dart';
import 'package:testador/features/test/domain/entities/question_entity.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';


import '../../../../../core/classes/usecase.dart';
import '../../failures/test_failures.dart';
import '../../repositories/test_repository.dart';

class UpdateTestUsecase
    extends UseCase<EditTestUsecaseResult, UpdateTestUsecaseParams> {
  const UpdateTestUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, EditTestUsecaseResult>> call(params) async {
    return testRepository.editTest(params);
  }
}

class UpdateTestUsecaseParams extends Params {
  final String testId;
  final DraftEntity test;

  const UpdateTestUsecaseParams({required this.testId, required this.test});
}

class EditTestUsecaseResult extends Response {
  final DraftEntity test;
  const EditTestUsecaseResult({required this.test});
}
