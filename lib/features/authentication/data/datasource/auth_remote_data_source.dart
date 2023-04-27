import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/auth_domain.dart';
import '../../domain/entities/auth_failure.dart';
import '../dtos/user_dto.dart';

abstract class AuthRemoteDataSource {
  Future<UserDto> registerUser(RegisterParams params);
  Future<UserDto> loginUser(LoginParams params);
  Future<UserDto> logInWithGoogle();
  Future<UserDto> getUserById(String id);
  Future<UserDto?> getLocalUser();
  Future<void> logUserOut();
}

class AuthFirebaseDataSourceIMPL implements AuthRemoteDataSource {
  AuthFirebaseDataSourceIMPL();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<UserDto> registerUser(RegisterParams params) async {
    final userCredentials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: params.email, password: params.password);

    final userId = userCredentials.user?.uid;
    if (userId == null) {
      throw AuthFailures.userNotFound;
    }

    final userDto = UserDto(
      email: params.email,
      id: userId,
      name: params.name,
    );

    await firestore
        .collection('users')
        .doc(userId)
        .set(userDto.toSnapshotData());

    return userDto;
  }

  @override
  Future<UserDto> getUserById(String id) async {
    final document = await firestore.collection('users').doc(id).get();

    if (!document.exists) {
      await FirebaseAuth.instance.currentUser!.delete();
      throw AuthFailures.userNotFound;
    }

    return UserDto.fromSnapshot(document);
  }

  @override
  Future<UserDto> loginUser(LoginParams params) async {
    final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: params.email, password: params.password);

    final user = response.user;

    if (user == null) {
      throw AuthFailures.userNotFound;
    }
    return getUserById(user.uid);
  }

  @override
  Future<UserDto> logInWithGoogle() async {
    late final AuthCredential credential;

    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;

    credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredentials =
        await _firebaseAuth.signInWithCredential(credential);

    final user = userCredentials.user;

    if (user == null) {
      throw AuthFailures.userNotFound;
    }

    return UserDto.empty();
  }

  @override
  Future<void> logUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<UserDto?> getLocalUser() async {
    final localUserId = FirebaseAuth.instance.currentUser?.uid;
    if (localUserId == null) {
      return null;
    }
    return getUserById(localUserId);
  }
}
