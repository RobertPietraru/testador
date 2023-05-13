import 'package:testador/features/test/domain/entities/test_entity.dart';
import 'package:testador/features/test/domain/entities/draft_entity.dart';

import 'package:dartz/dartz.dart';

import '../../../../../core/classes/usecase.dart';
import '../../failures/test_failures.dart';
import '../../repositories/test_repository.dart';

class CreateDraftUsecase
    extends UseCase<CreateDraftUsecaseResult, CreateDraftUsecaseParams> {
  const CreateDraftUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, CreateDraftUsecaseResult>> call(params) async {
    return testRepository.createTest(params);
  }
}

class CreateDraftUsecaseParams extends Params {
  final String creatorId;
  const CreateDraftUsecaseParams({
    required this.creatorId,
  });
}

class CreateDraftUsecaseResult extends Response {
  final  DraftEntity draft;
  const CreateDraftUsecaseResult({required this.draft});
}
