import 'package:equatable/equatable.dart';

abstract class Failure extends Error with EquatableMixin {
  final String code;
  Failure({required this.code});

  @override
  List<Object?> get props => [code];
}