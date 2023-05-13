import 'dart:io';
import 'package:testador/features/test/domain/entities/draft_entity.dart';

import 'package:testador/features/test/domain/entities/question_entity.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';

import 'package:dartz/dartz.dart';

import '../../../../../core/classes/usecase.dart';
import '../../failures/test_failures.dart';
import '../../repositories/test_repository.dart';

class UpdateQuestionImageUsecase extends UseCase<
    UpdateQuestionImageUsecaseResult, UpdateQuestionImageUsecaseParams> {
  const UpdateQuestionImageUsecase(this.testRepository);
  final TestRepository testRepository;
  @override
  Future<Either<TestFailure, UpdateQuestionImageUsecaseResult>> call(
      params) async {
    return testRepository.updateQuestionImage(params);
  }
}

class UpdateQuestionImageUsecaseParams extends Params {
  final DraftEntity draft;
  final int index;
  // if null, will remove the image
  final File image;
  const UpdateQuestionImageUsecaseParams(
      {required this.image, required this.draft, required this.index});
}

class UpdateQuestionImageUsecaseResult extends Response {
  final DraftEntity test;
  const UpdateQuestionImageUsecaseResult({required this.test});
}
