import 'package:dartz/dartz.dart';
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
  final String? title;
  final bool? isPublic;
  final String? imageUrl;

  const EditTestUsecaseParams(
      {required this.testId, this.title, this.isPublic, this.imageUrl});
}

class EditTestUsecaseResult extends Response {
  final TestEntity testEntity;
  const EditTestUsecaseResult({required this.testEntity});

}
