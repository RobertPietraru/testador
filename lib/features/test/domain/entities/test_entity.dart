import 'package:equatable/equatable.dart';

class TestEntity extends Equatable {
  final String id;
  final String? title;
  final bool isPublic;
  final String creatorId;
  final String? imageUrl;

  const TestEntity({
    required this.title,
    required this.isPublic,
    required this.creatorId,
    required this.imageUrl,
    required this.id,
  });

  @override
  List<Object?> get props => [id, title, isPublic, creatorId, imageUrl];
}
