import 'package:flutter/material.dart';
import 'package:testador/features/quiz/domain/failures/quiz_failures.dart';

class PlayerNameAlreadyInUseQuizFailure extends QuizFailure {
  PlayerNameAlreadyInUseQuizFailure(
      {super.code = 'player-name-already-in-use'});

  @override
  String retrieveMessage(BuildContext context) {
    return 'Numele pe care l-ai introdus tu, este deja folosit de cineva';
  }
}
