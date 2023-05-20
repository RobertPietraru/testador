import 'package:equatable/equatable.dart';

class PlayerEntity extends Equatable {
  final String userId;
  final String name;
  final double score;

  const PlayerEntity({
    required this.userId,
    required this.name,
    required this.score,
  });

  @override
  List<Object?> get props => [userId, name, score];

  PlayerEntity copyWith({String? userId, String? name, double? score}) {
    return PlayerEntity(
      score: score ?? this.score,
      userId: userId ?? this.userId,
      name: name ?? this.name,
    );
  }
}
