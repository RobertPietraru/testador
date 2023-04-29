import 'package:testador/features/authentication/domain/failures/auth_failure.dart';

class AuthConfirmPasswordEmptyValidationFailure extends AuthValidationFailure {
  AuthConfirmPasswordEmptyValidationFailure(
      {super.code = 'empty-confirm-Password'});
}

class AuthConfirmPasswordMatchFailure extends AuthValidationFailure {
  AuthConfirmPasswordMatchFailure({super.code = 'invalid-confirm-Password'});
}
