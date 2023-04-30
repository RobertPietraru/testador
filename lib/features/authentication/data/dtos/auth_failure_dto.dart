import 'package:testador/features/authentication/domain/failures/auth_failure.dart';

class AuthFailureDto {
  static AuthFailure fromFirebaseErrorCode(String code) {
    final failureConverter = {
      'internal-error': AuthUnknownFailure(code: code),
      'claims-too-large': AuthUnknownFailure(code: code),
      'invalid-hash-algorithm': AuthUnknownFailure(code: code),
      'invalid-hash-block-size': AuthUnknownFailure(code: code),
      'invalid-hash-derived-key-length': AuthUnknownFailure(code: code),
      'invalid-hash-key': AuthUnknownFailure(code: code),
      'invalid-hash-memory-cost': AuthUnknownFailure(code: code),
      'invalid-hash-parallelization': AuthUnknownFailure(code: code),
      'invalid-hash-rounds': AuthUnknownFailure(code: code),
      'invalid-hash-salt-separator': AuthUnknownFailure(code: code),
      'insufficient-permission': AuthAuthorizationFailure(code: code),
      'operation-not-allowed': AuthAuthorizationFailure(code: code),
      'missing-android-pkg-name': AuthUnknownFailure(code: code),
      'missing-oauth-client-secret	': AuthUnknownFailure(code: code),
      'project-not-found': AuthUnknownFailure(code: code),
      'reserved-claims': AuthUnknownFailure(code: code),
      'maximum-user-count-exceeded': AuthUnknownFailure(code: code),
      'unauthorized-continue-uri': AuthAuthorizationFailure(code: code),
      'email-already-exists': AuthInputBackendFailure(
          code: code, fieldWithIssue: FieldWithIssue.email),
      'email-already-in-use': AuthInputBackendFailure(
          code: code, fieldWithIssue: FieldWithIssue.email),
      'invalid-email': AuthInputBackendFailure(
          code: code, fieldWithIssue: FieldWithIssue.email),
      'invalid-password': AuthInputBackendFailure(
          code: code, fieldWithIssue: FieldWithIssue.password),
      'invalid-uid': AuthAuthorizationFailure(code: code),
      'invalid-phone-number': AuthValidationFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'invalid-display-name': AuthValidationFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'invalid-dynamic-link-domain': AuthInputBackendFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'invalid-creation-time': AuthInputBackendFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'invalid-disabled-field': AuthInputBackendFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'invalid-email-verified': AuthUnknownFailure(code: code),
      'invalid-photo-url': AuthValidationFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'invalid-credential': AuthValidationFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'invalid-argument': AuthValidationFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'invalid-claims': AuthValidationFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'invalid-continue-uri': AuthValidationFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'invalid-user-import': AuthValidationFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'invalid-id-token': AuthValidationFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'invalid-last-sign-in-time': AuthValidationFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'invalid-provider-data': AuthUnknownFailure(code: code),
      'invalid-provider-id': AuthUnknownFailure(code: code),
      'invalid-oauth-responsetype': AuthAuthorizationFailure(code: code),
      'missing-continue-uri': AuthUnknownFailure(code: code),
      'missing-hash-algorithm': AuthUnknownFailure(code: code),
      'missing-uid': AuthAuthorizationFailure(code: code),
      'invalid-page-token': AuthUnknownFailure(code: code),
      'phone-number-already-exists': AuthValidationFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'uid-already-exists': AuthInputBackendFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'user-not-found': AuthInputBackendFailure(
          code: code, fieldWithIssue: FieldWithIssue.email),
      'invalid-session-cookie-duration': AuthAuthorizationFailure(code: code),
      'session-cookie-expired': AuthAuthorizationFailure(code: code),
      'session-cookie-revoked': AuthAuthorizationFailure(code: code),
      'id-token-expired': AuthAuthorizationFailure(code: code),
      'id-token-revoked': AuthAuthorizationFailure(code: code),
      'invalid-password-hash': AuthInputBackendFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'invalid-password-salt': AuthInputBackendFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'missing-ios-bundle-id': AuthInputBackendFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'reserved-claims	': AuthInputBackendFailure(
          code: code, fieldWithIssue: FieldWithIssue.none),
      'wrong-password': AuthInputBackendFailure(
          code: code, fieldWithIssue: FieldWithIssue.password),
    };
    return failureConverter[code] ?? AuthUnknownFailure(code: code);
  }
}
