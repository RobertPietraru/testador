import 'package:testador/features/test/data/datasources/test_local_datasource.dart';
import 'package:testador/features/test/data/repositories/test_repository_impl.dart';
import 'package:testador/features/test/domain/repositories/test_repository.dart';
import 'package:testador/features/test/domain/usecases/draft/delete_draft_by_id.dart';

import '../../injection.dart';
import 'data/datasources/test_remote_datasource.dart';
import 'domain/usecases/test_usecases.dart';

void quizInject() {
  locator
    ..registerSingleton<QuizLocalDataSource>(QuizLocalDataSourceIMPL())
    ..registerSingleton<QuizRemoteDataSource>(QuizRemoteDataSourceIMPL())
    ..registerSingleton<QuizRepository>(
        QuizRepositoryIMPL(locator(), locator()))
    ..registerSingleton(CreateDraftUsecase(locator()))
    ..registerSingleton(DeleteDraftByIdUsecase(locator()))
    ..registerSingleton(UpdateQuizUsecase(locator()))
    ..registerSingleton(GetQuizsUsecase(locator()))
    ..registerSingleton(InsertQuestionUsecase(locator()))
    ..registerSingleton(DeleteQuestionUsecase(locator()))
    ..registerSingleton(UpdateQuestionUsecase(locator()))
    ..registerSingleton(UpdateQuestionImageUsecase(locator()))
    ..registerSingleton(MoveQuestionUsecase(locator()))
    ..registerSingleton(UpdateQuizImageUsecase(locator()))
    ..registerSingleton(SyncQuizUsecase(locator()))
    ..registerSingleton(GetQuizByIdUsecase(locator()))
    ..registerSingleton(GetDraftByIdUsecase(locator()));
}
