import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:testador/features/authentication/presentation/validation/errors/name_validation_failures.dart';

import '../../../domain/failures/auth_failure.dart';

/// {@template Name}
/// Form input for an Name input.
/// {@endtemplate}
class Name extends FormzInput<String, AuthValidationFailure>
    with EquatableMixin {
  /// {@macro Name}
  const Name.pure() : super.pure('');

  /// {@macro Name}
  const Name.dirty([super.value = '']) : super.dirty();

  @override
  AuthValidationFailure? validator(String? value) {
    return (value ?? '').isEmpty ? AuthNameEmptyValidationFailure() : null;
  }

  @override
  List<Object?> get props => [value, isValid, error];
}
