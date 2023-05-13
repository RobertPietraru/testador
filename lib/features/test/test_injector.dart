import 'package:testador/features/test/data/datasources/test_local_datasource.dart';
import 'package:testador/features/test/data/repositories/test_repository_impl.dart';
import 'package:testador/features/test/domain/repositories/test_repository.dart';
import 'package:testador/features/test/domain/usecases/draft/delete_draft_by_id.dart';

import '../../injection.dart';
import 'data/datasources/test_remote_datasource.dart';
import 'domain/usecases/test_usecases.dart';

void testInject() {
  locator
    ..registerSingleton<TestLocalDataSource>(TestLocalDataSourceIMPL())
    ..registerSingleton<TestRemoteDataSource>(TestRemoteDataSourceIMPL())
    ..registerSingleton<TestRepository>(
        TestRepositoryIMPL(locator(), locator()))
    ..registerSingleton(CreateDraftUsecase(locator()))
    ..registerSingleton(DeleteDraftByIdUsecase(locator()))
    ..registerSingleton(UpdateTestUsecase(locator()))
    ..registerSingleton(GetTestsUsecase(locator()))
    ..registerSingleton(InsertQuestionUsecase(locator()))
    ..registerSingleton(DeleteQuestionUsecase(locator()))
    ..registerSingleton(UpdateQuestionUsecase(locator()))
    ..registerSingleton(UpdateQuestionImageUsecase(locator()))
    ..registerSingleton(MoveQuestionUsecase(locator()))
    ..registerSingleton(UpdateTestImageUsecase(locator()))
    ..registerSingleton(SyncTestUsecase(locator()))
    ..registerSingleton(GetTestByIdUsecase(locator()))
    ..registerSingleton(GetDraftByIdUsecase(locator()));
}
