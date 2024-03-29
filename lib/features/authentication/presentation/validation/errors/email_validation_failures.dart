import 'package:flutter/material.dart';
import 'package:testador/core/utils/translator.dart';
import 'package:testador/features/authentication/domain/failures/auth_failure.dart';

class AuthEmailEmptyValidationFailure extends AuthValidationFailure {
  AuthEmailEmptyValidationFailure({super.code = 'empty-email'});

  @override
  String retrieveMessage(BuildContext context) {
    return context.translator.youMustProvideAnEmail;
  }
}

class AuthEmailInvalidFailure extends AuthValidationFailure {
  AuthEmailInvalidFailure({super.code = 'invalid-email'});

  @override
  String retrieveMessage(BuildContext context) {
    return context.translator.emailIsInvalid;
  }
}
