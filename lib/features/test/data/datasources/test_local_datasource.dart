import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testador/features/authentication/domain/failures/auth_failure.dart';

import '../../domain/entities/test_entity.dart';

abstract class TestRemoteDataSource {
  Future<TestEntity> createTest();
  Future<TestEntity> deleteTest();
  Future<TestEntity> saveTestToDatabase();
  Future<TestEntity> changeTestTitle();
  Future<TestEntity> toggleTestPublicity();
  Future<TestEntity> changeTestDescription();
  Future<TestEntity> changeTestImage();
  Future<TestEntity> insertQuestion();
  Future<TestEntity> deleteQuestion();
  Future<TestEntity> updateQuestion();
}

class TestLocalDataSourceIMPL implements TestRemoteDataSource {
  TestLocalDataSourceIMPL();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  @override
  Future<TestEntity> changeTestDescription() {
    // TODO: implement changeTestDescription
    throw UnimplementedError();
  }
  
  @override
  Future<TestEntity> changeTestImage() {
    // TODO: implement changeTestImage
    throw UnimplementedError();
  }
  
  @override
  Future<TestEntity> changeTestTitle() {
    // TODO: implement changeTestTitle
    throw UnimplementedError();
  }
  
  @override
  Future<TestEntity> createTest() {
    // TODO: implement createTest
    throw UnimplementedError();
  }
  
  @override
  Future<TestEntity> deleteQuestion() {
    // TODO: implement deleteQuestion
    throw UnimplementedError();
  }
  
  @override
  Future<TestEntity> deleteTest() {
    // TODO: implement deleteTest
    throw UnimplementedError();
  }
  
  @override
  Future<TestEntity> insertQuestion() {
    // TODO: implement insertQuestion
    throw UnimplementedError();
  }
  
  @override
  Future<TestEntity> saveTestToDatabase() {
    // TODO: implement saveTestToDatabase
    throw UnimplementedError();
  }
  
  @override
  Future<TestEntity> toggleTestPublicity() {
    // TODO: implement toggleTestPublicity
    throw UnimplementedError();
  }
  
  @override
  Future<TestEntity> updateQuestion() {
    // TODO: implement updateQuestion
    throw UnimplementedError();
  }
}
