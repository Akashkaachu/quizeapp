// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionDetailsAdapter extends TypeAdapter<QuestionDetails> {
  @override
  final int typeId = 1;

  @override
  QuestionDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionDetails(
      question: fields[0] as String,
      answer: fields[1] as String,
      option1: fields[2] as String,
      option2: fields[3] as String,
      option3: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionDetails obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.answer)
      ..writeByte(2)
      ..write(obj.option1)
      ..writeByte(3)
      ..write(obj.option2)
      ..writeByte(4)
      ..write(obj.option3);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
