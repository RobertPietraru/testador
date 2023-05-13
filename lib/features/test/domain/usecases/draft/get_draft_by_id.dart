import 'package:testador/features/test/domain/entities/draft_entity.dart';

import '../../../../../core/classes/usecase.dart';
import '../../failures/test_failures.dart';
import '../../repositories/test_repository.dart';

import 'package:dartz/dartz.dart';

class GetDraftByIdUsecase
    extends UseCase<GetDraftByIdUsecaseResult, GetDraftByIdUsecaseParams> {
  const GetDraftByIdUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, GetDraftByIdUsecaseResult>> call(params) async {
    return testRepository.getDraftById(params);
  }
}

class GetDraftByIdUsecaseParams extends Params {
  final String testId;
  const GetDraftByIdUsecaseParams({required this.testId});
}

class GetDraftByIdUsecaseResult extends Response {
  final DraftEntity testEntity;
  const GetDraftByIdUsecaseResult({required this.testEntity});
}
