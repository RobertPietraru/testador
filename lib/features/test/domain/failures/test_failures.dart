import 'package:flutter/material.dart';

import '../../../../core/classes/failure.dart';

abstract class TestFailure extends Failure {
  const TestFailure({required super.code});
  @override
  List<Object?> get props => [code];

  /// Returns the error message translated to the current language
  String retrieveMessage(BuildContext context);
}

class TestNetworkFailure extends TestFailure {
  const TestNetworkFailure({super.code = 'network-request-failed'});

  @override
  String retrieveMessage(BuildContext context) {
    return "Nu esti conectat la internet";
  }
}

class TestNotFoundFailure extends TestFailure {
  const TestNotFoundFailure({super.code = 'test-not-found'});

  @override
  String retrieveMessage(BuildContext context) {
    return 'Testul cautat nu a fost gasit';
  }
}

class TestUnknownFailure extends TestFailure {
  const TestUnknownFailure({super.code = 'unknown'});

  @override
  String retrieveMessage(BuildContext context) {
    return 'A aparut o eroare. Codul: $code';
  }
}
