import 'package:hive_flutter/adapters.dart';
import 'package:testador/features/quiz/data/datasources/image_data_source.dart';
import 'package:testador/features/quiz/data/dtos/draft/draft_dto.dart';
import 'package:testador/features/quiz/domain/entities/draft_entity.dart';
import 'package:testador/features/quiz/domain/usecases/draft/delete_draft_by_id.dart';
import 'package:uuid/uuid.dart';

import '../../domain/failures/quiz_failures.dart';
import '../../domain/usecases/quiz_usecases.dart';
import '../dtos/question/question_dto.dart';

abstract class QuizLocalDataSource {
  Future<DraftEntity> getDraftById(GetDraftByIdUsecaseParams params);
  Future<DraftEntity> moveQuestion(MoveQuestionUsecaseParams params);
  Future<DraftEntity> createDraft(CreateDraftUsecaseParams params);

  Future<DraftEntity> updateQuiz(UpdateQuizUsecaseParams params);
  Future<List<DraftEntity>> getDrafts(GetQuizesUsecaseParams params);
  Future<DraftEntity> insertQuestion(InsertQuestionUsecaseParams params);
  Future<DraftEntity> deleteQuestion(DeleteQuestionUsecaseParams params);
  Future<DraftEntity> updateQuestion(UpdateQuestionUsecaseParams params);
  Future<DraftEntity> updateQuestionImage(
      UpdateQuestionImageUsecaseParams params);

  Future<void> deleteDraftById(DeleteDraftByIdUsecaseParams params);

  Future<DraftEntity> updateQuizImage(UpdateQuizImageUsecaseParams params);
}

class QuizLocalDataSourceIMPL implements QuizLocalDataSource {
  QuizLocalDataSourceIMPL();

  final Box<DraftDto> draftsBox = Hive.box<DraftDto>(DraftDto.hiveBoxName);
  final imageDB = ImageDataSource();

  @override
  Future<DraftEntity> createDraft(CreateDraftUsecaseParams params) async {
    final id = const Uuid().v1();
    final draftDto = DraftDto(
      creatorId: params.creatorId,
      id: id,
      imageId: null,
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
            quizId: id,
            type: QuestionTypeDto.multipleChoice)
      ],
    );
    draftsBox.put(id, draftDto);
    return draftDto.toEntity();
  }

  @override
  Future<DraftEntity> deleteQuestion(DeleteQuestionUsecaseParams params) async {
    final questions =
        params.quiz.questions.map((e) => QuestionDto.fromEntity(e)).toList();

    questions.removeAt(params.index);

    final dto = DraftDto(
      questions: questions,
      title: params.quiz.title,
      isPublic: params.quiz.isPublic,
      creatorId: params.quiz.creatorId,
      imageId: params.quiz.imageId,
      id: params.quiz.id,
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
      imageId: params.draft.imageId,
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
  Future<DraftEntity> updateQuiz(UpdateQuizUsecaseParams params) async {
    draftsBox.put(params.quizId, DraftDto.fromEntity(params.quiz));
    return params.quiz;
  }

  @override
  Future<List<DraftEntity>> getDrafts(GetQuizesUsecaseParams params) async {
    return draftsBox.values
        .where((element) => element.creatorId == params.creatorId)
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<DraftEntity> getDraftById(GetDraftByIdUsecaseParams params) async {
    final quiz = draftsBox.get(params.quizId);
    if (quiz == null) {
      throw const QuizNotFoundFailure();
    }
    return quiz.toEntity();
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
  Future<void> deleteDraftById(DeleteDraftByIdUsecaseParams params) async {
    await draftsBox.delete(params.draftId);
  }

  @override
  Future<DraftEntity> updateQuestionImage(
      UpdateQuestionImageUsecaseParams params) async {
    var question = QuestionDto.fromEntity(params.draft.questions[params.index]);
    final newQuestions = params.draft.questions.toList();

    final imageID = await imageDB.cacheImage(params.image);
    question = question.copyWith(image: imageID);

    newQuestions[params.index] = question.toEntity();

    final dto =
        DraftDto.fromEntity(params.draft.copyWith(questions: newQuestions));
    draftsBox.put(dto.id, dto);
    return dto.toEntity();
  }

  @override
  Future<DraftEntity> updateQuizImage(
      UpdateQuizImageUsecaseParams params) async {
    final imageID = await imageDB.cacheImage(params.image);
    final dto = DraftDto.fromEntity(params.draft.copyWith(imageId: imageID));
    draftsBox.put(dto.id, dto);
    return dto.toEntity();
  }
}
