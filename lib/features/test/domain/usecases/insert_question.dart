 import '../failures/test_failures.dart'; import 'package:dartz/dartz.dart'; import '../../../../core/classes/usecase.dart'; import '../repositories/test_repository.dart'; class InsertQuestionUsecase extends UseCase<InsertQuestionUsecaseResult, InsertQuestionUsecaseParams> { const InsertQuestionUsecase(this.testRepository); final TestRepository testRepository; @override Future<Either<TestFailure, InsertQuestionUsecaseResult>> call(params) async { return testRepository.insertQuestion(params); } } class InsertQuestionUsecaseParams extends Params { const InsertQuestionUsecaseParams(); } class InsertQuestionUsecaseResult extends Response { const InsertQuestionUsecaseResult(); }