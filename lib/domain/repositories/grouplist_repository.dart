import 'package:listzilla/domain/models/group_list_model.dart';

abstract class GroupListRepositoryInterface {

  void addGroupList(GroupList groupList);

  void addTaskListInGroup(String taskListID, String groupListID);

  void deleteGroupList(String groupListID);

  List<GroupList?> getAllGroupLists();

  GroupList? getGroupList(String groupListID);

  List<String?> getListsFromGroup(String groupListID);

  GroupList newGroupList(String groupListName, int groupListColor);

  void removeTaskListInGroup(String taskListID, String groupListID);

  void updateGroupListColor(int newColor, String groupListID);

  void updateGroupListName(String newName, String groupListID);
}
