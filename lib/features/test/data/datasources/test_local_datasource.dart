import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path/path.dart';
import 'package:testador/features/test/data/dtos/draft/draft_dto.dart';
import 'package:testador/features/test/data/dtos/test/test_dto.dart';
import 'package:testador/features/test/domain/entities/draft_entity.dart';
import 'package:testador/features/test/domain/usecases/draft/delete_draft_by_id.dart';
import 'package:uuid/uuid.dart';

import '../../domain/failures/test_failures.dart';
import '../../domain/usecases/test_usecases.dart';
import '../dtos/question/question_dto.dart';

abstract class TestLocalDataSource {
  Future<DraftEntity> getDraftById(GetDraftByIdUsecaseParams params);
  Future<DraftEntity> moveQuestion(MoveQuestionUsecaseParams params);
  Future<DraftEntity> createDraft(CreateDraftUsecaseParams params);
  Future<DraftEntity> updateTestImage(UpdateTestImageUsecaseParams params);

  Future<DraftEntity> updateTest(UpdateTestUsecaseParams params);
  Future<List<DraftEntity>> getDrafts(GetTestsUsecaseParams params);
  Future<DraftEntity> insertQuestion(InsertQuestionUsecaseParams params);
  Future<DraftEntity> deleteQuestion(DeleteQuestionUsecaseParams params);
  Future<DraftEntity> updateQuestion(UpdateQuestionUsecaseParams params);
  Future<DraftEntity> updateQuestionImage(
      UpdateQuestionImageUsecaseParams params);

  Future<void> deleteDraftById(DeleteDraftByIdUsecaseParams params);
}

class TestLocalDataSourceIMPL implements TestLocalDataSource {
  TestLocalDataSourceIMPL();

  final Box<DraftDto> draftsBox = Hive.box<DraftDto>(DraftDto.hiveBoxName);
  final storage = FirebaseStorage.instance;

  @override
  Future<DraftEntity> createDraft(CreateDraftUsecaseParams params) async {
    final id = const Uuid().v1();
    final draftDto = DraftDto(
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
            type: QuestionTypeDto.multipleChoice)
      ],
    );
    draftsBox.put(id, draftDto);
    return draftDto.toEntity();
  }

  @override
  Future<DraftEntity> deleteQuestion(DeleteQuestionUsecaseParams params) async {
    final questions =
        params.test.questions.map((e) => QuestionDto.fromEntity(e)).toList();

    questions.removeAt(params.index);

    final dto = DraftDto(
      questions: questions,
      title: params.test.title,
      isPublic: params.test.isPublic,
      creatorId: params.test.creatorId,
      imageUrl: params.test.imageUrl,
      id: params.test.id,
    );
    draftsBox.put(dto.id, dto);
    return dto.toEntity();
  }

  @override
  Future<DraftEntity> insertQuestion(InsertQuestionUsecaseParams params) async {
    final questions =
        params.draft.questions.map((e) => QuestionDto.fromEntity(e)).toList();

    questions.insert(params.index, QuestionDto.fromEntity(params.question));

    final dto = DraftDto(
      questions: questions,
      title: params.draft.title,
      isPublic: params.draft.isPublic,
      creatorId: params.draft.creatorId,
      imageUrl: params.draft.imageUrl,
      id: params.draft.id,
    );
    draftsBox.put(dto.id, dto);
    return dto.toEntity();
  }

  @override
  Future<DraftEntity> updateQuestion(UpdateQuestionUsecaseParams params) async {
    var dto = DraftDto.fromEntity(params.draft);

    final questions = dto.questions.toList();
    questions[params.index] =
        QuestionDto.fromEntity(params.replacementQuestion);
    dto = dto.copyWith(questions: questions.toList());

    draftsBox.put(dto.id, dto);
    return dto.toEntity();
  }

  @override
  Future<DraftEntity> updateTest(UpdateTestUsecaseParams params) async {
    draftsBox.put(params.testId, DraftDto.fromEntity(params.test));
    return params.test;
  }

  @override
  Future<List<DraftEntity>> getDrafts(GetTestsUsecaseParams params) async {
    return draftsBox.values
        .where((element) => element.creatorId == params.creatorId)
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<DraftEntity> getDraftById(GetDraftByIdUsecaseParams params) async {
    final test = draftsBox.get(params.testId);
    if (test == null) {
      throw const TestNotFoundFailure();
    }
    return test.toEntity();
  }

  @override
  Future<DraftEntity> moveQuestion(MoveQuestionUsecaseParams params) async {
    var dto = DraftDto.fromEntity(params.draft);
    final questions = dto.questions.toList();

    final question = questions[params.oldIndex];

    if (params.oldIndex < params.newIndex) {
      questions.insert(params.newIndex, question);
      questions.removeAt(params.oldIndex);
    } else {
      questions.removeAt(params.oldIndex);
      questions.insert(params.newIndex, question);
    }

    dto = dto.copyWith(questions: questions);
    draftsBox.put(dto.id, dto);
    return dto.toEntity();
  }

  @override
  Future<DraftEntity> updateQuestionImage(
      UpdateQuestionImageUsecaseParams params) async {
    var dto = DraftDto.fromEntity(params.draft);

    final questions = dto.questions.toList();
    String url = await uploadImage(
        params.draft.creatorId, params.draft.id, params.image);

    questions[params.index] = questions[params.index].copyWith(image: url);

    dto = dto.copyWith(questions: questions.toList());

    await draftsBox.put(dto.id, dto);
    return dto.toEntity();
  }

  Future<String> uploadImage(
      String creatorId, String testId, File image) async {
    final fileExtension = basename(image.path).split('.').last;
    final path = '$creatorId/$testId/${const Uuid().v1()}.$fileExtension';

    final snap = await storage.ref(path).putFile(image);
    final url = await snap.ref.getDownloadURL();

    return url;
  }

  @override
  Future<DraftEntity> updateTestImage(
      UpdateTestImageUsecaseParams params) async {
    final imageUrl =
        await uploadImage(params.test.creatorId, params.test.id, params.image);
    final test = params.test.copyWith(imageUrl: imageUrl);
    draftsBox.put(test.id, DraftDto.fromEntity(test));
    return test;
  }

  @override
  Future<void> deleteDraftById(DeleteDraftByIdUsecaseParams params) async {
    await draftsBox.delete(params.draftId);
  }
}
