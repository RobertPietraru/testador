import 'package:equatable/equatable.dart';

class TestEntity extends Equatable {
  final String id;
  final String title;
  final bool isPublic;
  final String creator;
  final String? image;
  const TestEntity({
    required this.title,
    required this.isPublic,
    required this.creator,
    required this.image,
    required this.id,
  });

  @override
  List<Object?> get props => [id, title, isPublic, creator, image];
}
