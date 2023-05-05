import 'package:isar/isar.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';

@collection
@Name("Test")
class TestDto extends TestEntity {
  static const collectionName = "Test";
  const TestDto({
    required super.title,
    required super.isPublic,
    required super.creator,
    required super.id,
    required super.image,
  });
}
