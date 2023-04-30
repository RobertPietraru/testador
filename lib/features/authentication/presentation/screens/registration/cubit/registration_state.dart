part of 'registration_cubit.dart';

enum RegistrationStatus { error, loading, successful, init }

class RegistrationState extends Equatable {
  const RegistrationState({
    required this.name,
    required this.email,
    required this.password,
    this.failure,
    this.status = RegistrationStatus.init,
  });

  final Email email;
  final Password password;
  final Name name;
  final RegistrationStatus status;
  final AuthFailure? failure;

  @override
  List<Object?> get props => [name, email, password, status, failure];

  bool get isValid {
    return validationFailure == null;
  }

  bool get isSuccessful {
    return status == RegistrationStatus.successful;
  }

  String? nameFailure(BuildContext context) {
    return failure?.fieldWithIssue == FieldWithIssue.name
        ? failure?.retrieveMessage(context)
        : null;
  }

  String? emailFailure(BuildContext context) {
    return failure?.fieldWithIssue == FieldWithIssue.email
        ? failure?.retrieveMessage(context)
        : null;
  }

  String? passwordFailure(BuildContext context) {
    return failure?.fieldWithIssue == FieldWithIssue.password
        ? failure?.retrieveMessage(context)
        : null;
  }

  bool get isInvalid {
    return !isValid;
  }

  AuthFailure? get validationFailure {
    return password.error ?? email.error ?? name.error;
  }

  RegistrationState copyWith({
    Name? name,
    Email? email,
    Password? password,
    RegistrationStatus? status,
    AuthFailure? failure = const NoAuthFailure(),
  }) =>
      RegistrationState(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        failure: failure == const NoAuthFailure() ? this.failure : failure,
      );
}
