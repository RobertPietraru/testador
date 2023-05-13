import 'package:testador/features/test/domain/entities/test_entity.dart';
import 'package:testador/features/test/domain/entities/draft_entity.dart';

import '../../failures/test_failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/classes/usecase.dart';
import '../../repositories/test_repository.dart';

class SyncTestUsecase
    extends UseCase<SyncTestUsecaseResult, SyncTestUsecaseParams> {
  const SyncTestUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, SyncTestUsecaseResult>> call(params) async {
    return testRepository.syncTest(params);
  }
}

class SyncTestUsecaseParams extends Params {
  final DraftEntity draft;
  const SyncTestUsecaseParams({required this.draft});
}

class SyncTestUsecaseResult extends Response {
  const SyncTestUsecaseResult();
}
