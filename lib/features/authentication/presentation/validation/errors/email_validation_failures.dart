import 'package:testador/features/authentication/domain/failures/auth_failure.dart';

class AuthEmailEmptyValidationFailure extends AuthValidationFailure {
  AuthEmailEmptyValidationFailure({super.code = 'empty-email'});
}

class AuthEmailInvalidFailure extends AuthValidationFailure {
  AuthEmailInvalidFailure({super.code = 'invalid-email'});
}
