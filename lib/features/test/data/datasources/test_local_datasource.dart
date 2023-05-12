import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path/path.dart';
import 'package:testador/features/test/data/dtos/test/question_dto.dart';
import 'package:testador/features/test/data/dtos/test/test_dto.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/test_entity.dart';
import '../../domain/failures/test_failures.dart';
import '../../domain/usecases/test_usecases.dart';

abstract class TestDataSource {
  Future<TestEntity> getTestById(GetTestByIdUsecaseParams params);
  Future<TestEntity> moveQuestion(MoveQuestionUsecaseParams params);
  Future<TestEntity> createTest(CreateTestUsecaseParams params);
  Future<void> deleteTest(DeleteTestUsecaseParams params);

  Future<TestEntity> editTest(EditTestUsecaseParams params);
  Future<List<TestEntity>> getTests(GetTestsUsecaseParams params);
  Future<TestEntity> insertQuestion(InsertQuestionUsecaseParams params);
  Future<TestEntity> deleteQuestion(DeleteQuestionUsecaseParams params);
  Future<TestEntity> updateQuestion(UpdateQuestionUsecaseParams params);
  Future<TestEntity> updateQuestionImage(
      UpdateQuestionImageUsecaseParams params);
}

class TestLocalDataSourceIMPL implements TestDataSource {
  TestLocalDataSourceIMPL();

  final Box<TestDto> testsBox = Hive.box<TestDto>(TestDto.hiveBoxName);
  final storage = FirebaseStorage.instance;

  @override
  Future<TestEntity> createTest(CreateTestUsecaseParams params) async {
    final id = const Uuid().v1();
    final testDto = TestDto(
      creatorId: params.creatorId,
      id: id,
      imageUrl: null,
      isPublic: false,
      title: null,
      questions: [
        QuestionDto(
            id: const Uuid().v1(),
            text: null,
            options: [
              const MultipleChoiceOptionDto(text: null, isCorrect: false),
              const MultipleChoiceOptionDto(text: null, isCorrect: false),
            ],
            acceptedAnswers: null,
            testId: id,
            typeDto: QuestionTypeDto.multipleChoice)
      ],
    );
    testsBox.put(id, testDto);
    return testDto.toEntity();
  }

  @override
  Future<TestEntity> deleteQuestion(DeleteQuestionUsecaseParams params) async {
    final questions =
        params.test.questions.map((e) => QuestionDto.fromEntity(e)).toList();

    questions.removeAt(params.index);

    final dto = TestDto(
      questions: questions,
      title: params.test.title,
      isPublic: params.test.isPublic,
      creatorId: params.test.creatorId,
      imageUrl: params.test.imageUrl,
      id: params.test.id,
    );
    testsBox.put(dto.id, dto);
    return dto.toEntity();
  }

  @override
  Future<void> deleteTest(DeleteTestUsecaseParams params) async {
    await testsBox.delete(params.testId);
  }

  @override
  Future<TestEntity> insertQuestion(InsertQuestionUsecaseParams params) async {
    final questions =
        params.test.questions.map((e) => QuestionDto.fromEntity(e)).toList();

    questions.insert(params.index, QuestionDto.fromEntity(params.question));

    final dto = TestDto(
      questions: questions,
      title: params.test.title,
      isPublic: params.test.isPublic,
      creatorId: params.test.creatorId,
      imageUrl: params.test.imageUrl,
      id: params.test.id,
    );
    testsBox.put(dto.id, dto);
    return dto.toEntity();
  }

  @override
  Future<TestEntity> updateQuestion(UpdateQuestionUsecaseParams params) async {
    final questions =
        params.test.questions.map((e) => QuestionDto.fromEntity(e)).toList();
    questions[params.index] =
        QuestionDto.fromEntity(params.replacementQuestion);

    final dto = TestDto(
      questions: questions.toList(),
      title: params.test.title,
      isPublic: params.test.isPublic,
      creatorId: params.test.creatorId,
      imageUrl: params.test.imageUrl,
      id: params.test.id,
    );
    testsBox.put(dto.id, dto);
    return dto.toEntity();
  }

  @override
  Future<TestEntity> editTest(EditTestUsecaseParams params) async {
    final test = testsBox.get(params.testId);

    if (test == null) throw const TestNotFoundFailure();
    final newTest = TestDto(
      title: params.title,
      isPublic: params.isPublic ?? test.isPublic,
      creatorId: test.creatorId,
      imageUrl: params.imageUrl ?? test.imageUrl,
      id: params.testId,
      questions:
          params.questions?.map((e) => QuestionDto.fromEntity(e)).toList() ??
              test.questions,
    );
    testsBox.put(newTest.id, newTest);
    return newTest.toEntity();
  }

  @override
  Future<List<TestEntity>> getTests(GetTestsUsecaseParams params) async {
    return testsBox.values
        .where((element) => element.creatorId == params.creatorId)
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<TestEntity> getTestById(GetTestByIdUsecaseParams params) async {
    final test = testsBox.get(params.testId);
    if (test == null) {
      throw const TestNotFoundFailure();
    }
    return test.toEntity();
  }

  @override
  Future<TestEntity> moveQuestion(MoveQuestionUsecaseParams params) async {
    final questions =
        params.test.questions.map((e) => QuestionDto.fromEntity(e)).toList();

    final question = questions[params.oldIndex];

    if (params.oldIndex < params.newIndex) {
      questions.insert(params.newIndex, question);
      questions.removeAt(params.oldIndex);
    } else {
      questions.removeAt(params.oldIndex);
      questions.insert(params.newIndex, question);
    }

    final dto = TestDto(
      questions: questions,
      title: params.test.title,
      isPublic: params.test.isPublic,
      creatorId: params.test.creatorId,
      imageUrl: params.test.imageUrl,
      id: params.test.id,
    );
    testsBox.put(dto.id, dto);
    return dto.toEntity();
  }

  @override
  Future<TestEntity> updateQuestionImage(
      UpdateQuestionImageUsecaseParams params) async {
    final questions = params.test.questions.toList();
    // final questions = params.test.questions.map((e) => QuestionDto.fromEntity(e)).toList();
    final fileExtension = basename(params.image.path).split('.').last;

    final path =
        '${params.test.creatorId}/${params.test.id}/${const Uuid().v1()}.$fileExtension';
    final snap = await storage.ref(path).putFile(params.image);
    final url = await snap.ref.getDownloadURL();
    questions[params.index] = questions[params.index].copyWith(image: url);

    final entity = TestEntity(
        questions: questions.toList(),
        title: params.test.title,
        isPublic: params.test.isPublic,
        creatorId: params.test.creatorId,
        imageUrl: params.test.imageUrl,
        id: params.test.id);
    await testsBox.put(entity.id, TestDto.fromEntity(entity));
    return entity;
  }
}
