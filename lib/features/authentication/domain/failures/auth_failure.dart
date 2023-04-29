import 'package:flutter/material.dart';

import '../../../../core/classes/failure.dart';

enum FieldWithIssue { email, password, name, none }

abstract class AuthFailure extends Failure {
  AuthFailure({required super.code});

  /// Returns the error message translated to the current language
  String retrieveMessage(BuildContext context);
}

class AuthValidationFailure extends AuthFailure {
  final FieldWithIssue fieldWithIssue;
  AuthValidationFailure(
      {required super.code, this.fieldWithIssue = FieldWithIssue.none});

  @override
  String retrieveMessage(BuildContext context) {
    throw UnimplementedError();
  }
}

class AuthDatabaseFailure extends AuthFailure {
  AuthDatabaseFailure({required super.code});

  @override
  String retrieveMessage(BuildContext context) {
    throw UnimplementedError();
  }
}

class AuthAuthorizationFailure extends AuthFailure {
  AuthAuthorizationFailure({required super.code});

  @override
  String retrieveMessage(BuildContext context) {
    throw UnimplementedError();
  }
}

class AuthNetworkFailure extends AuthFailure {
  AuthNetworkFailure({required super.code});

  @override
  String retrieveMessage(BuildContext context) {
    throw UnimplementedError();
  }
}

class AuthBackendFailure extends AuthFailure {
  final FieldWithIssue fieldWithIssue;
  AuthBackendFailure(
      {required super.code, this.fieldWithIssue = FieldWithIssue.none});

  @override
  String retrieveMessage(BuildContext context) {
    throw UnimplementedError();
  }
}

class AuthUserNotFound extends AuthBackendFailure {
  AuthUserNotFound({super.code = 'user-not-found'});
}

class AuthUnknownFailure extends AuthFailure {
  AuthUnknownFailure({super.code = 'uknown'});

  @override
  String retrieveMessage(BuildContext context) {
    throw UnimplementedError();
  }
}
