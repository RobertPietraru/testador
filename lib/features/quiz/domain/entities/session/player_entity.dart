import 'package:equatable/equatable.dart';

class PlayerEntity extends Equatable {
  final String userId;
  final String name;

  const PlayerEntity({required this.userId, required this.name});

  @override
  List<Object?> get props => [userId, name];

  PlayerEntity copyWith({String? userId, String? name}) {
    return PlayerEntity(
      userId: userId ?? this.userId,
      name: name ?? this.name,
    );
  }
}
