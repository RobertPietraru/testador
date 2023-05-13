import 'package:flutter/material.dart';
import 'package:testador/features/authentication/domain/failures/auth_failure.dart';

class AuthPasswordEmptyValidationFailure extends AuthValidationFailure {
  AuthPasswordEmptyValidationFailure({super.code = 'empty-password'});

  @override
  String retrieveMessage(BuildContext context) =>
      'Trebuie sa introduceti o parola';
}

class AuthPasswordInvalidFailure extends AuthValidationFailure {
  AuthPasswordInvalidFailure({super.code = 'invalid-password'});

  @override
  String retrieveMessage(BuildContext context) =>
      'Parola este prea slaba sau invalida';
}
