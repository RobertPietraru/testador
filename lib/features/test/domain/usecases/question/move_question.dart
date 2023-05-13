import 'package:testador/features/test/domain/entities/draft_entity.dart';

import 'package:dartz/dartz.dart';

import '../../../../../core/classes/usecase.dart';
import '../../failures/test_failures.dart';
import '../../repositories/test_repository.dart';

class MoveQuestionUsecase
    extends UseCase<MoveQuestionUsecaseResult, MoveQuestionUsecaseParams> {
  const MoveQuestionUsecase(this.quizRepository);
  final QuizRepository quizRepository;
  @override
  Future<Either<QuizFailure, MoveQuestionUsecaseResult>> call(params) async {
    return quizRepository.moveQuestion(params);
  }
}

class MoveQuestionUsecaseParams extends Params {
  final DraftEntity draft;
  final int oldIndex;
  final int newIndex;
  const MoveQuestionUsecaseParams({
    required this.oldIndex,
    required this.newIndex,
    required this.draft,
  });
}

class MoveQuestionUsecaseResult extends Response {
  final DraftEntity quiz;
  const MoveQuestionUsecaseResult({required this.quiz});
}
