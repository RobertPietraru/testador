import 'package:testador/features/test/domain/entities/draft_entity.dart';
import 'package:dartz/dartz.dart';


import '../../../../../core/classes/usecase.dart';
import '../../failures/test_failures.dart';
import '../../repositories/test_repository.dart';

class DeleteTestUsecase
    extends UseCase<DeleteTestUsecaseResult, DeleteTestUsecaseParams> {
  const DeleteTestUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, DeleteTestUsecaseResult>> call(params) async {
    return testRepository.deleteTest(params);
  }
}

class DeleteTestUsecaseParams extends Params {
  final String testId;
  const DeleteTestUsecaseParams({required this.testId});
}

class DeleteTestUsecaseResult extends Response {
  const DeleteTestUsecaseResult();
}
