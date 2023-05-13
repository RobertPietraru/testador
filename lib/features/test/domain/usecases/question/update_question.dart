import 'package:testador/features/test/domain/entities/question_entity.dart';
import 'package:testador/features/test/domain/entities/draft_entity.dart';

import 'package:dartz/dartz.dart';

import '../../../../../core/classes/usecase.dart';
import '../../failures/test_failures.dart';
import '../../repositories/test_repository.dart';

class UpdateQuestionUsecase
    extends UseCase<UpdateQuestionUsecaseResult, UpdateQuestionUsecaseParams> {
  const UpdateQuestionUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, UpdateQuestionUsecaseResult>> call(params) async {
    return testRepository.updateQuestion(params);
  }
}

class UpdateQuestionUsecaseParams extends Params {
  final DraftEntity draft;
  final QuestionEntity replacementQuestion;
  final int index;
  const UpdateQuestionUsecaseParams(
      {required this.draft,
      required this.replacementQuestion,
      required this.index});
}

class UpdateQuestionUsecaseResult extends Response {
  final DraftEntity testEntity;
  const UpdateQuestionUsecaseResult({required this.testEntity});
}
