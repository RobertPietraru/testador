import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testador/features/test/data/dtos/test/test_dto.dart';
import 'package:testador/features/test/domain/usecases/test_usecases.dart';

abstract class TestRemoteDataSource {
  Future<void> syncToDatabase(SyncTestUsecaseParams params);
}

class TestRemoteDataSourceIMPL implements TestRemoteDataSource {
  final db = FirebaseFirestore.instance;

  @override
  Future<void> syncToDatabase(SyncTestUsecaseParams params) async {
    final test = TestDto.fromEntity(params.test.copyWith(needsSync: false));

    await db.collection('tests').doc(test.id).set(test.toMap());
  }
  
}
