import 'package:testador/features/authentication/domain/failures/auth_failure.dart';

class AuthPasswordEmptyValidationFailure extends AuthValidationFailure {
  AuthPasswordEmptyValidationFailure({super.code = 'empty-password'});
}

class AuthPasswordInvalidFailure extends AuthValidationFailure {
  AuthPasswordInvalidFailure({super.code = 'invalid-password'});
}
