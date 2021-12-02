// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodoro_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PomodoroAdapter extends TypeAdapter<Pomodoro> {
  @override
  final int typeId = 4;

  @override
  Pomodoro read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pomodoro(
      id: fields[0] as String,
      dateCompleted: fields[1] as DateTime,
      lengthInSeconds: fields[2] as int,
      taskID: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Pomodoro obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateCompleted)
      ..writeByte(2)
      ..write(obj.lengthInSeconds)
      ..writeByte(3)
      ..write(obj.taskID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PomodoroAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
