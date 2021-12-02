// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupListAdapter extends TypeAdapter<GroupList> {
  @override
  final int typeId = 2;

  @override
  GroupList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupList(
      id: fields[0] as String,
      index: fields[1] as int,
      name: fields[2] as String,
      colorTag: fields[3] as int,
      listsID: (fields[4] as List).cast<String?>(),
    );
  }

  @override
  void write(BinaryWriter writer, GroupList obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.index)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.colorTag)
      ..writeByte(4)
      ..write(obj.listsID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}