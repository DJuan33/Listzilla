// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 3;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as String,
      dataAdded: fields[1] as bool,
      themeMode: fields[2] as int,
      groupListsID: (fields[3] as List).cast<String?>(),
      pomodorosID: (fields[4] as List).cast<String?>(),
      pomodoroLongBreakLength: fields[5] as int,
      pomodoroShortBreakLength: fields[6] as int,
      pomodorosLength: fields[7] as int,
      pomodorosToBreak: fields[8] as int,
      calendarWeekFirstDay: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dataAdded)
      ..writeByte(2)
      ..write(obj.themeMode)
      ..writeByte(3)
      ..write(obj.groupListsID)
      ..writeByte(4)
      ..write(obj.pomodorosID)
      ..writeByte(5)
      ..write(obj.pomodoroLongBreakLength)
      ..writeByte(6)
      ..write(obj.pomodoroShortBreakLength)
      ..writeByte(7)
      ..write(obj.pomodorosLength)
      ..writeByte(8)
      ..write(obj.pomodorosToBreak)
      ..writeByte(9)
      ..write(obj.calendarWeekFirstDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
