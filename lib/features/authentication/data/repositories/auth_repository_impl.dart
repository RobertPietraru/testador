import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/classes/usecase.dart';
import '../../domain/auth_domain.dart';
import '../../domain/entities/auth_failure.dart';
import '../datasource/auth_remote_data_source.dart';
import '../dtos/auth_failure_dto.dart';

class AuthRepositoryIMPL implements AuthRepository {
  const AuthRepositoryIMPL(
    this.authRemoteDataSource,
  );

  final AuthRemoteDataSource authRemoteDataSource;

  @override
  Future<Either<AuthFailure, UserEntity>> registerUser(
      RegisterParams params) async {
    try {
      final userEntity = await authRemoteDataSource.registerUser(params);
      return Right(userEntity);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailureDto.fromFirebaseAuthException(e));
    } on AuthFailure catch (error) {
      return Left(error);
    } catch (_) {
      return const Left(AuthFailureDto(
        code: 'unknown',
        message: null,
        type: AuthFailureType.unknown,
      ));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> logInWithGoogle(
      NoParams noParams) async {
    try {
      final response = await authRemoteDataSource.logInWithGoogle();

      return Right(response);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailureDto.fromFirebaseAuthException(e));
    } on AuthFailure catch (error) {
      return Left(error);
    } catch (e) {
      return Left(AuthFailureDto.unknown);
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> loginUser(LoginParams params) async {
    try {
      final entity = await authRemoteDataSource.loginUser(params);
      return Right(entity);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailureDto.fromFirebaseAuthException(e));
    } on AuthFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AuthFailureDto.unknown);
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> getUserById(String id) async {
    try {
      final entity = await authRemoteDataSource.getUserById(id);
      return Right(entity);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailureDto.fromFirebaseAuthException(e));
    } on AuthFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AuthFailureDto.unknown);
    }
  }

  @override
  Future<Either<AuthFailure, void>> logUserOut() async {
    try {
      final response = await authRemoteDataSource.logUserOut();
      return Right(response);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailureDto.fromFirebaseAuthException(e));
    } on AuthFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AuthFailureDto.unknown);
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity?>> getLocalUser() async {
    try {
      final entity = await authRemoteDataSource.getLocalUser();
      return Right(entity);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailureDto.fromFirebaseAuthException(e));
    } on AuthFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AuthFailureDto.unknown);
    }
  }
}
