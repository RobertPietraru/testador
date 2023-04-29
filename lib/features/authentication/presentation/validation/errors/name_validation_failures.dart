import 'package:testador/features/authentication/domain/failures/auth_failure.dart';

class AuthNameEmptyValidationFailure extends AuthValidationFailure {
  AuthNameEmptyValidationFailure({super.code = 'empty-name'});
}

class AuthNameInvalidFailure extends AuthValidationFailure {
  AuthNameInvalidFailure({super.code = 'invalid-name'});
}
