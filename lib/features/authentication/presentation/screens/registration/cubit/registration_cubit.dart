import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../domain/failures/auth_failure.dart';
import '../../../../domain/usecases/register_usecase.dart';
import '../../../auth_bloc/auth_bloc.dart';
import '../../../validation/forms/email.dart';
import '../../../validation/forms/name.dart';
import '../../../validation/forms/password.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final RegisterUsecase registerUsecase;
  final AuthBloc authBloc;

  RegistrationCubit(this.registerUsecase, {required this.authBloc})
      : super(const RegistrationState(
          status: RegistrationStatus.init,
          email: Email.dirty(),
          password: Password.dirty(),
          name: Name.dirty(),
        ));
  void onEmailChanged(String email) {
    final newEmail = Email.dirty(email);
    emit(state.copyWith(
        email: newEmail, status: RegistrationStatus.init, failure: null));
  }

  void onNameChanged(String name) {
    final newName = Name.dirty(name);
    emit(state.copyWith(
      name: newName,
      status: RegistrationStatus.init,
      failure: null,
    ));
  }

  void onPasswordChanged(String password) {
    final newPassword = Password.dirty(password);
    emit(state.copyWith(
      password: newPassword,
      status: RegistrationStatus.init,
      failure: null,
    ));
  }

  void validateInput() {
    Formz.validate([state.name, state.password, state.name]);
    final validationFailure = state.validationFailure;

    emit(state.copyWith(
      failure: validationFailure,
      status: validationFailure != null
          ? RegistrationStatus.error
          : RegistrationStatus.init,
    ));
  }

  Future<void> register() async {
    validateInput();
    if (state.isInvalid) {
      return;
    }
    emit(state.copyWith(status: RegistrationStatus.loading));
    final response = await registerUsecase.call(
      RegisterParams(
        name: state.name.value,
        email: state.email.value,
        password: state.password.value,
      ),
    );
    return response.fold((failure) {
      emit(state.copyWith(
        status: RegistrationStatus.error,
        failure: failure,
      ));
    }, (user) {
      emit(state.copyWith(
        status: RegistrationStatus.successful,
      ));
      authBloc.add(AuthUserLoggedIn(entity: user));
    });
  }
}
