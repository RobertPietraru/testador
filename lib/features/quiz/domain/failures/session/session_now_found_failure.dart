import 'package:flutter/material.dart';

import '../quiz_failures.dart';

class SessionNotFoundFailure extends QuizFailure {
  const SessionNotFoundFailure({super.code = 'session-not-found'});

  @override
  String retrieveMessage(BuildContext context) {
    return 'Sesiunea cautata nu a fost gasita';
  }
}
