import 'package:equatable/equatable.dart';

import '../../../domain/entities/session/player_entity.dart';

class PlayerDto extends Equatable {
  final String userId;
  final String name;

  static const String userIdField = 'userId';
  static const String nameField = 'name';

  const PlayerDto({required this.userId, required this.name});

  @override
  List<Object?> get props => [userId, name];

  PlayerDto copyWith({String? userId, String? name}) {
    return PlayerDto(
      userId: userId ?? this.userId,
      name: name ?? this.name,
    );
  }

  factory PlayerDto.fromEntity(PlayerDto player) {
    return PlayerDto(
      userId: player.userId,
      name: player.name,
    );
  }
  PlayerEntity toEntity(PlayerDto player) {
    return PlayerEntity(
      userId: player.userId,
      name: player.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      userIdField: userId,
      nameField: name,
    };
  }

  factory PlayerDto.fromMap(Map<String, dynamic> map) {
    return PlayerDto(userId: map[userIdField], name: map[nameField]);
  }
}
