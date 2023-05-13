import 'package:flutter/material.dart';
import 'package:testador/features/authentication/domain/failures/auth_failure.dart';

class AuthConfirmPasswordEmptyValidationFailure extends AuthValidationFailure {
  AuthConfirmPasswordEmptyValidationFailure(
      {super.code = 'empty-confirm-Password'});

  @override
  String retrieveMessage(BuildContext context) => 'Trebuie sa confirmi parola';
}

class AuthConfirmPasswordMatchFailure extends AuthValidationFailure {
  AuthConfirmPasswordMatchFailure({super.code = 'invalid-confirm-Password'});

  @override
  String retrieveMessage(BuildContext context) => "Parolele nu se potrivesc";
}
