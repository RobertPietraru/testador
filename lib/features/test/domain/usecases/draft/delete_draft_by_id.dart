import 'package:testador/features/test/domain/entities/draft_entity.dart';

import '../../../../../core/classes/usecase.dart';
import '../../failures/test_failures.dart';
import '../../repositories/test_repository.dart';

import 'package:dartz/dartz.dart';

class DeleteDraftByIdUsecase extends UseCase<DeleteDraftByIdUsecaseResult,
    DeleteDraftByIdUsecaseParams> {
  const DeleteDraftByIdUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, DeleteDraftByIdUsecaseResult>> call(params) async {
    return testRepository.deleteDraftById(params);
  }
}

class DeleteDraftByIdUsecaseParams extends Params {
  final String draftId;
  const DeleteDraftByIdUsecaseParams({required this.draftId});
}

class DeleteDraftByIdUsecaseResult extends Response {
  const DeleteDraftByIdUsecaseResult();
}
