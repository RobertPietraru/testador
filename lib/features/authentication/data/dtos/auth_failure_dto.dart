import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/auth_failure.dart';

class AuthFailureDto extends AuthFailure {
  const AuthFailureDto(
      {required super.type, required super.message, required super.code});
  factory AuthFailureDto.fromFirebaseAuthException(
      FirebaseAuthException firebaseAuthException) {
    final failureConverter = {
      'internal-error': AuthFailureType.backend,
      'claims-too-large': AuthFailureType.backend,
      'invalid-hash-algorithm': AuthFailureType.backend,
      'invalid-hash-block-size': AuthFailureType.backend,
      'invalid-hash-derived-key-length': AuthFailureType.backend,
      'invalid-hash-key': AuthFailureType.backend,
      'invalid-hash-memory-cost': AuthFailureType.backend,
      'invalid-hash-parallelization': AuthFailureType.backend,
      'invalid-hash-rounds': AuthFailureType.backend,
      'invalid-hash-salt-separator': AuthFailureType.backend,
      'insufficient-permission': AuthFailureType.unauthorised,
      'operation-not-allowed': AuthFailureType.unauthorised,
      'missing-android-pkg-name': AuthFailureType.backend,
      'missing-oauth-client-secret	': AuthFailureType.unauthorised,
      'project-not-found': AuthFailureType.backend,
      'reserved-claims': AuthFailureType.backend,
      'maximum-user-count-exceeded': AuthFailureType.backend,
      'unauthorized-continue-uri': AuthFailureType.unauthorised,
      'email-already-exists': AuthFailureType.badEmail,
      'email-already-in-use': AuthFailureType.badEmail,
      'invalid-email': AuthFailureType.badEmail,
      'invalid-password': AuthFailureType.badPassword,
      'invalid-uid': AuthFailureType.backend,
      'invalid-phone-number': AuthFailureType.badPhone,
      'invalid-display-name': AuthFailureType.badInput,
      'invalid-dynamic-link-domain': AuthFailureType.backend,
      'invalid-creation-time': AuthFailureType.backend,
      'invalid-disabled-field': AuthFailureType.backend,
      'invalid-email-verified': AuthFailureType.badEmail,
      'invalid-photo-url': AuthFailureType.badInput,
      'invalid-credential': AuthFailureType.badInput,
      'invalid-argument': AuthFailureType.badInput,
      'invalid-claims': AuthFailureType.badInput,
      'invalid-continue-uri': AuthFailureType.badInput,
      'invalid-user-import': AuthFailureType.badInput,
      'invalid-id-token': AuthFailureType.badInput,
      'invalid-last-sign-in-time': AuthFailureType.badInput,
      'invalid-page-token': AuthFailureType.badInput,
      'invalid-provider-data': AuthFailureType.badInput,
      'invalid-provider-id': AuthFailureType.badInput,
      'invalid-oauth-responsetype': AuthFailureType.badInput,
      'missing-continue-uri': AuthFailureType.badInput,
      'missing-hash-algorithm': AuthFailureType.badInput,
      'missing-uid': AuthFailureType.badInput,
      'phone-number-already-exists': AuthFailureType.badPassword,
      'uid-already-exists': AuthFailureType.backend,
      'user-not-found': AuthFailureType.badInput,
      'invalid-session-cookie-duration': AuthFailureType.logoutRequired,
      'session-cookie-expired': AuthFailureType.logoutRequired,
      'session-cookie-revoked': AuthFailureType.logoutRequired,
      'id-token-expired': AuthFailureType.logoutRequired,
      'id-token-revoked': AuthFailureType.logoutRequired,
      'invalid-password-hash': AuthFailureType.backend,
      'invalid-password-salt': AuthFailureType.backend,
      'missing-ios-bundle-id': AuthFailureType.backend,
      'reserved-claims	': AuthFailureType.backend,
      'wrong-password': AuthFailureType.badInput,
    };

    final messageConverter = {
      'email-already-exists': 'This email is already in use. Please log in',
      'invalid-email': 'The email you provided is invalid',
      'invalid-password': 'The password you provided is invalid',
      'user-not-found': 'Wrong email or password. Please try again',
      'wrong-password': 'Wrong email or password. Please try again',
      'email-already-in-use': "Email already in use",
    };
    final type =
        failureConverter[firebaseAuthException.code] ?? AuthFailureType.unknown;
    final message = messageConverter[firebaseAuthException.code] ??
        firebaseAuthException.message;

    return AuthFailureDto(
        type: type, message: message, code: firebaseAuthException.code);
  }

  // ignore: prefer_constructors_over_static_methods
  static AuthFailureDto get unknown {
    return const AuthFailureDto(
      type: AuthFailureType.unknown,
      message: null,
      code: 'unknown',
    );
  }
}
