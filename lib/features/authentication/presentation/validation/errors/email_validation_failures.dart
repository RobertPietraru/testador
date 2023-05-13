import 'package:flutter/material.dart';
import 'package:testador/features/authentication/domain/failures/auth_failure.dart';

class AuthEmailEmptyValidationFailure extends AuthValidationFailure {
  AuthEmailEmptyValidationFailure({super.code = 'empty-email'});

  @override
  String retrieveMessage(BuildContext context) {
    return "Trebuie sa introduceti un email";
  }
}

class AuthEmailInvalidFailure extends AuthValidationFailure {
  AuthEmailInvalidFailure({super.code = 'invalid-email'});

  @override
  String retrieveMessage(BuildContext context) {
    return 'Emailul este invalid';
  }
}
