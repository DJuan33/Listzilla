import 'package:listzilla/domain/models/group_list_model.dart';
import 'package:listzilla/domain/repositories/grouplist_repository.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class GroupListRepositoryHive implements GroupListRepositoryInterface {
  Box<GroupList> groupListBox = Hive.box('GROUP');

  @override
  void addGroupList(GroupList groupList) {
    groupListBox.put(groupList.id, groupList);
  }

  @override
  void addTaskListInGroup(String taskListID, String groupListID) {
    GroupList? groupList = getGroupList(groupListID);

    if (groupList != null) {
      groupList.listsID.add(taskListID);
      groupListBox.put(groupList.id, groupList);
    }
  }


  @override
  List<GroupList?> getAllGroupLists() {
    List<GroupList?> groupLists = [];

    for (var x in groupListBox.keys) {
      GroupList? groupFinded = groupListBox.get(x);

      groupLists.add(groupFinded);
    }

    return groupLists;
  }

  @override
  GroupList? getGroupList(String groupListID) => groupListBox.get(groupListID);

  @override
  GroupList newGroupList(String groupName, int groupColor) {
    int newGroupListIndex = groupListBox.values.length;
    String newGroupListID = const Uuid().v4();

    GroupList newGroupList = GroupList(
        colorTag: groupColor,
        name: groupName,
        index: newGroupListIndex,
        listsID: [],
        id: newGroupListID);

    addGroupList(newGroupList);
    return newGroupList;
  }

  @override
  void removeTaskListInGroup(String taskListID, String groupListID) {
    GroupList? groupFinded = getGroupList(groupListID);
    List<String?> oldLists = getListsFromGroup(groupListID);

    List<String?> newTaskLists = [];
    if (groupFinded != null) {
      for (var x in oldLists) {
        if (x != taskListID) {
          newTaskLists.add(x);
        }
      }
      GroupList groupListUpdated = GroupList(
          id: groupFinded.id,
          name: groupFinded.name,
          listsID: newTaskLists,
          colorTag: groupFinded.colorTag,
          index: groupFinded.index);

      groupListBox.put(groupListUpdated.id, groupListUpdated);
    }
  }

  @override
  void deleteGroupList(String groupListID) {
    GroupList? groupFinded = getGroupList(groupListID);

    if (groupFinded != null) {
      for (var x in groupFinded.listsID) {
        if (x != null) {
          removeTaskListInGroup(x, groupListID);
        }
      }
    }

  groupListBox.delete(groupListID);
  }

  @override
  void updateGroupListColor(int newColor, String groupListID) {
    GroupList? groupFinded = getGroupList(groupListID);

    if (groupFinded != null) {
      GroupList groupListUpdated = GroupList(
          id: groupFinded.id,
          name: groupFinded.name,
          listsID: groupFinded.listsID,
          colorTag: newColor,
          index: groupFinded.index);

      groupListBox.put(groupListUpdated.id, groupListUpdated);
    }
  }

  @override
  void updateGroupListName(String newName, String groupListID) {
    GroupList? groupFinded = getGroupList(groupListID);

    if (groupFinded != null) {
      GroupList groupListUpdated = GroupList(
          id: groupFinded.id,
          name: newName,
          listsID: groupFinded.listsID,
          colorTag: groupFinded.colorTag,
          index: groupFinded.index);

      groupListBox.put(groupListUpdated.id, groupListUpdated);
    }
  }

  @override
  List<String?> getListsFromGroup(String groupListID) {
    GroupList? groupFinded = getGroupList(groupListID);
    List<String?> lists = [];

    if (groupFinded != null) {
      lists = groupFinded.listsID;
    }

    return lists;
  }
}
