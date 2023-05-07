import 'package:flutter/material.dart';
import 'package:testador/features/test/domain/failures/test_failures.dart';

class DeletingTheOnlyQuestionTestFailure extends TestFailure {
  DeletingTheOnlyQuestionTestFailure({super.code = 'deleting-only-question'});

  @override
  String retrieveMessage(BuildContext context) {
    return 'Testul tau are doar o intrebare. Din cauza asta nu o poti sterge';
  }
}
