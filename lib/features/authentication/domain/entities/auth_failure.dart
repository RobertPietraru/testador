import '../../../../core/classes/failure.dart';

enum AuthFailureType {
  badName,
  badInput,
  badEmail,
  badPassword,
  badPhone,
  backend,
  noInternet,
  unauthorised,
  logoutRequired,
  unknown,
}

class AuthFailure extends Failure {
  const AuthFailure(
      {required this.type, required this.message, required this.code});

  final AuthFailureType type;
  final String? message;
  final String code;

  bool get isInputRelated {
    return ([
      AuthFailureType.badEmail,
      AuthFailureType.badPassword,
      AuthFailureType.badPhone,
      AuthFailureType.badInput
    ].contains(type));
  }

  factory AuthFailure.fromEmailValidationError({required String message}) {
    return AuthFailures.invalidEmail.copyWith(message: message);
  }
  factory AuthFailure.fromPasswordValidationError({required String message}) {
    return AuthFailures.invalidPassword.copyWith(message: message);
  }

  AuthFailure copyWith({
    AuthFailureType? type,
    String? message = 'potato',
    String? code,
  }) {
    return AuthFailure(
      type: type ?? this.type,
      message: message == 'potato' ? this.message : message,
      code: code ?? this.code,
    );
  }

  /// this is for the copyWith function
  static const mock = AuthFailure(
      type: AuthFailureType.unknown,
      message: 'alsdkfjasldfkjasdfowiejrl;askdjfasjsqoeiwra',
      code: 'asdf;lkajsdflasdjfskdjfa;ldslfkjsadfasdflkj');

  @override
  List<Object?> get props => [type, code];
}

abstract class AuthFailures {
  static const AuthFailure userNotFound = AuthFailure(
    type: AuthFailureType.badEmail,
    message: "The email you provided doesn't correspond to any user. "
        'Please try again with another email',
    code: 'user-not-found',
  );

  static const AuthFailure invalidPassword = AuthFailure(
      type: AuthFailureType.badPassword,
      message: 'The password you provided is invalid',
      code: 'invalid-password');
  static const AuthFailure invalidEmail = AuthFailure(
      type: AuthFailureType.badEmail,
      message: 'The email you provided is invalid',
      code: 'invalid-email');
  static const AuthFailure emptyName = AuthFailure(
      type: AuthFailureType.badName,
      message: 'You need to provide a name',
      code: 'empty-name');
}
