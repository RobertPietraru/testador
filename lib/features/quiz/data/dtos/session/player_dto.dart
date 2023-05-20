import 'package:equatable/equatable.dart';

import '../../../domain/entities/session/player_entity.dart';

class PlayerDto extends Equatable {
  final String userId;
  final String name;
  final double score;

  static const String userIdField = 'userId';
  static const String scoreField = 'score';
  static const String nameField = 'name';

  const PlayerDto(
      {required this.userId, required this.name, required this.score});

  @override
  List<Object?> get props => [userId, name];

  PlayerDto copyWith({String? userId, String? name, double? score}) {
    return PlayerDto(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      score: score ?? this.score,
    );
  }

  factory PlayerDto.fromEntity(PlayerEntity player) {
    return PlayerDto(
        userId: player.userId, name: player.name, score: player.score);
  }
  PlayerEntity toEntity(PlayerDto player) {
    return PlayerEntity(
        userId: player.userId, name: player.name, score: player.score);
  }

  Map<dynamic, dynamic> toMap() {
    return {userIdField: userId, nameField: name, scoreField: score};
  }

  factory PlayerDto.fromMap(Map<dynamic, dynamic> map) {
    return PlayerDto(
        userId: map[userIdField], name: map[nameField], score: map[scoreField]);
  }
}
