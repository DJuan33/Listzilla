// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      id: fields[0] as String,
      index: fields[1] as int,
      name: fields[2] as String,
      completed: fields[3] as bool,
      priority: fields[4] as bool,
      description: fields[5] as String,
      creationDate: fields[6] as DateTime,
      expirationDate: fields[7] as DateTime,
      pomodoro: fields[8] as DateTime,
      myDay: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.index)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.completed)
      ..writeByte(4)
      ..write(obj.priority)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.creationDate)
      ..writeByte(7)
      ..write(obj.expirationDate)
      ..writeByte(8)
      ..write(obj.pomodoro)
      ..writeByte(9)
      ..write(obj.myDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
