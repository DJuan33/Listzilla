import 'dart:core';
import 'package:hive/hive.dart';

part 'group_list_model.g.dart';

@HiveType(typeId: 2)
class GroupList {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int index;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final int colorTag;

  @HiveField(4)
  final List<String?> listsID;

  GroupList({
    required this.id,
    required this.index,
    required this.name,
    required this.colorTag,
    required this.listsID,
  });
}
