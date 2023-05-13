import 'package:equatable/equatable.dart';
import 'package:testador/features/test/domain/entities/draft_entity.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';

import 'package:dartz/dartz.dart';

import '../../../../../core/classes/usecase.dart';
import '../../failures/test_failures.dart';
import '../../repositories/test_repository.dart';

class GetQuizsUsecase
    extends UseCase<GetQuizsUsecaseResult, GetQuizsUsecaseParams> {
  const GetQuizsUsecase(this.quizRepository);
  final QuizRepository quizRepository;
  @override
  Future<Either<QuizFailure, GetQuizsUsecaseResult>> call(params) async {
    return quizRepository.getQuizs(params);
  }
}

class GetQuizsUsecaseParams extends Params {
  final String creatorId;
  const GetQuizsUsecaseParams({required this.creatorId});
}

class GetQuizsUsecaseResult extends Response {
  final List<QuizDraftPair> pairs;
  const GetQuizsUsecaseResult({required this.pairs});
}

class QuizDraftPair extends Equatable {
  final QuizEntity quiz;
  final DraftEntity? draft;

  const QuizDraftPair({required this.quiz, this.draft});

  @override
  List<Object?> get props => [quiz, draft];
}
