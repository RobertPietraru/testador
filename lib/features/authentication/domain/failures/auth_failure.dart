import 'package:flutter/material.dart';

import '../../../../core/classes/failure.dart';

enum FieldWithIssue { email, password, name, none }

abstract class AuthFailure extends Failure {
  const AuthFailure({required super.code, required this.fieldWithIssue});
  @override
  List<Object?> get props => [code, fieldWithIssue];

  final FieldWithIssue fieldWithIssue;

  /// Returns the error message translated to the current language
  String retrieveMessage(BuildContext context);
}

class AuthValidationFailure extends AuthFailure {
  const AuthValidationFailure(
      {required super.code, super.fieldWithIssue = FieldWithIssue.none});

  @override
  String retrieveMessage(BuildContext context) {
    throw UnimplementedError();
  }
}

class AuthDatabaseFailure extends AuthFailure {
  const AuthDatabaseFailure(
      {required super.code, super.fieldWithIssue = FieldWithIssue.none});

  @override
  String retrieveMessage(BuildContext context) {
    throw UnimplementedError();
  }
}

class AuthAuthorizationFailure extends AuthFailure {
  const AuthAuthorizationFailure(
      {required super.code, super.fieldWithIssue = FieldWithIssue.none});

  @override
  String retrieveMessage(BuildContext context) {
    throw UnimplementedError();
  }
}

class AuthNetworkFailure extends AuthFailure {
  const AuthNetworkFailure(
      {required super.code, super.fieldWithIssue = FieldWithIssue.none});

  @override
  String retrieveMessage(BuildContext context) {
    throw UnimplementedError();
  }
}

class AuthInputBackendFailure extends AuthFailure {
  const AuthInputBackendFailure({
    required super.code,
    super.fieldWithIssue = FieldWithIssue.none,
  });

  @override
  String retrieveMessage(BuildContext context) {
    throw UnimplementedError();
  }
}

class AuthUserNotFound extends AuthInputBackendFailure {
  const AuthUserNotFound({super.code = 'user-not-found'});
}

class AuthUnknownFailure extends AuthFailure {
  const AuthUnknownFailure(
      {super.code = 'uknown', super.fieldWithIssue = FieldWithIssue.none});

  @override
  String retrieveMessage(BuildContext context) {
    throw UnimplementedError();
  }
}

class NoAuthFailure extends AuthFailure {
  const NoAuthFailure(
      {super.code = "no-auth-failure",
      super.fieldWithIssue = FieldWithIssue.none});

  @override
  String retrieveMessage(BuildContext context) {
    throw UnimplementedError();
  }
}
