import 'package:flutter/material.dart';
import 'package:testador/features/quiz/domain/failures/quiz_failures.dart';

class DeletingTheOnlyQuestionQuizFailure extends QuizFailure {
  DeletingTheOnlyQuestionQuizFailure({super.code = 'deleting-only-question'});

  @override
  String retrieveMessage(BuildContext context) {
    return 'Quizul tau are doar o intrebare. Din cauza asta nu o poti sterge';
  }
}