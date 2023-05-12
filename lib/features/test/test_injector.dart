import 'package:testador/features/test/data/datasources/test_local_datasource.dart';
import 'package:testador/features/test/data/repositories/test_repository_impl.dart';
import 'package:testador/features/test/domain/repositories/test_repository.dart';

import '../../injection.dart';
import 'domain/usecases/test_usecases.dart';

void testInject() {
  locator
    ..registerSingleton<TestDataSource>(TestLocalDataSourceIMPL())
    ..registerSingleton<TestRepository>(TestRepositoryIMPL(locator()))
    ..registerSingleton(CreateTestUsecase(locator()))
    ..registerSingleton(DeleteTestUsecase(locator()))
    ..registerSingleton(SaveTestToDatabaseUsecase(locator()))
    ..registerSingleton(EditTestUsecase(locator()))
    ..registerSingleton(GetTestsUsecase(locator()))
    ..registerSingleton(InsertQuestionUsecase(locator()))
    ..registerSingleton(DeleteQuestionUsecase(locator()))
    ..registerSingleton(UpdateQuestionUsecase(locator()))
    ..registerSingleton(UpdateQuestionImageUsecase(locator()))
    ..registerSingleton(MoveQuestionUsecase(locator()))
    ..registerSingleton(GetTestByIdUsecase(locator()));
}
