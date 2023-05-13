import 'package:dartz/dartz.dart';
import 'package:testador/features/test/domain/entities/draft_entity.dart';
import 'package:testador/features/test/domain/entities/question_entity.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';

import '../../../../../core/classes/usecase.dart';
import '../../failures/test_failures.dart';
import '../../repositories/test_repository.dart';

class UpdateQuizUsecase
    extends UseCase<EditQuizUsecaseResult, UpdateQuizUsecaseParams> {
  const UpdateQuizUsecase(this.quizRepository);
  final QuizRepository quizRepository;
  @override
  Future<Either<QuizFailure, EditQuizUsecaseResult>> call(params) async {
    return quizRepository.editQuiz(params);
  }
}

class UpdateQuizUsecaseParams extends Params {
  final String quizId;
  final DraftEntity quiz;

  const UpdateQuizUsecaseParams({required this.quizId, required this.quiz});
}

class EditQuizUsecaseResult extends Response {
  final DraftEntity quiz;
  const EditQuizUsecaseResult({required this.quiz});
}
