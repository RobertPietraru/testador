// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionDtoAdapter extends TypeAdapter<QuestionDto> {
  @override
  final int typeId = 2;

  @override
  QuestionDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionDto(
      id: fields[7] as String,
      text: fields[6] as String?,
      image: fields[3] as String?,
      options: (fields[4] as List?)?.cast<MultipleChoiceOptionDto>(),
      acceptedAnswers: (fields[5] as List?)?.cast<String>(),
      testId: fields[1] as String,
      type: fields[2] as QuestionTypeDto,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionDto obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.testId)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.options)
      ..writeByte(5)
      ..write(obj.acceptedAnswers)
      ..writeByte(6)
      ..write(obj.text)
      ..writeByte(7)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MultipleChoiceOptionDtoAdapter
    extends TypeAdapter<MultipleChoiceOptionDto> {
  @override
  final int typeId = 3;

  @override
  MultipleChoiceOptionDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MultipleChoiceOptionDto(
      text: fields[0] as String?,
      isCorrect: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MultipleChoiceOptionDto obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.isCorrect);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultipleChoiceOptionDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuestionTypeDtoAdapter extends TypeAdapter<QuestionTypeDto> {
  @override
  final int typeId = 4;

  @override
  QuestionTypeDto read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return QuestionTypeDto.multipleChoice;
      case 1:
        return QuestionTypeDto.answer;
      default:
        return QuestionTypeDto.multipleChoice;
    }
  }

  @override
  void write(BinaryWriter writer, QuestionTypeDto obj) {
    switch (obj) {
      case QuestionTypeDto.multipleChoice:
        writer.writeByte(0);
        break;
      case QuestionTypeDto.answer:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionTypeDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
