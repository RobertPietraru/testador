import '../../entities/test_entity.dart';
import '../../failures/test_failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/classes/usecase.dart';
import '../../repositories/test_repository.dart';
import 'package:testador/features/test/domain/entities/draft_entity.dart';

class DeleteQuestionUsecase
    extends UseCase<DeleteQuestionUsecaseResult, DeleteQuestionUsecaseParams> {
  const DeleteQuestionUsecase(this.quizRepository);
  final QuizRepository quizRepository;
  @override
  Future<Either<QuizFailure, DeleteQuestionUsecaseResult>> call(params) async {
    return quizRepository.deleteQuestion(params);
  }
}

class DeleteQuestionUsecaseParams extends Params {
  final DraftEntity quiz;
  final int index;
  const DeleteQuestionUsecaseParams({required this.quiz, required this.index});
}

class DeleteQuestionUsecaseResult extends Response {
  final DraftEntity quizEntity;
  const DeleteQuestionUsecaseResult({required this.quizEntity});
}
