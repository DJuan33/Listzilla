import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listzilla/domain/controllers/sidebar/sidebar_screen_state.dart';
import 'package:listzilla/domain/models/group_list_model.dart';
import 'package:listzilla/domain/models/task_list_model.dart';
import 'package:listzilla/domain/repositories/grouplist_repository.dart';
import 'package:listzilla/domain/repositories/tasklist_repository.dart';
import 'package:listzilla/domain/repositories/task_repository.dart';

/// The contreller for the SibebarScreen.
/// This class works managing [TaskList] and [GroupList] entities.
class SidebarScreenController extends Cubit<SidebarScreenState> {
  // Injected repositories.
  GroupListRepositoryInterface groupListDBConnection;
  TaskListRepositoryInterface taskListDBConnection;
  TaskRepositoryInterface taskDBConnection;

  SidebarScreenController({
    required this.groupListDBConnection,
    required this.taskListDBConnection,
    required this.taskDBConnection,
  }) : super(SidebarScreenState.initial);

  /// This method override the initial state of the controller with the repositories data.
  void onInit() {
    _getGroupsLists();
    _getTasksListsFromGroup();
  }

  /// Returns a list of [GroupList] from the repostory.
  List<GroupList?> getAllGroupLists() {
    return groupListDBConnection.getAllGroupLists();
  }

  /// Get the user list of [GroupList], call [_getTasksListsFromGroup()], and emit a new state with them.
  void _getGroupsLists() {
    // Initial variables.
    List<GroupList?> groupListsFinded =
        groupListDBConnection.getAllGroupLists();

    Map<String, List<TaskList?>> taskLists = {};

    for (var groupList in groupListsFinded) {
      if (groupList != null) taskLists[groupList.id] = [];
    }

    List<GroupList?> groupLists =
        List<GroupList?>.filled(groupListsFinded.length, null);

    // For every [GroupList], add it to the empty list according to his index.
    for (var x in groupListsFinded) {
      if (x != null) {
        groupLists[x.index] = x;
      }
    }

    emit(state.copyWith(
      groupLists: groupLists,
      taskLists: taskLists,
    ));
  }

  void _getTasksListsFromGroup() {
    for (var x in state.groupLists) {
      if (x != null) {
        _setTaskLists(x.id, x.listsID);
      }
    }
  }

  void _setTaskLists(String groupID, List<String?> lists) {
    List<TaskList?> taskListsFinded = [];

    for (var x in lists) {
      if (x != null) {
        TaskList? taskList = taskListDBConnection.getTaskList(x);
        if (taskList != null) {
          taskListsFinded.add(taskList);
        }
      }
    }

    Map<String, List<TaskList?>> stateTaskLists = state.taskLists;
    stateTaskLists[groupID] = taskListsFinded;

    emit(
      state.copyWith(
        taskLists: stateTaskLists,
      ),
    );
  }

  void newTaskList(
      String groupListID, String taskListName, String taskListEmoji) {
    String newTaskListID =
        taskListDBConnection.newTaskList(taskListName, taskListEmoji);
    groupListDBConnection.addTaskListInGroup(newTaskListID, groupListID);
    _getGroupsLists();
    _getTasksListsFromGroup();
  }

  void newGroupList({required String groupName, required int groupColor}) {
    groupListDBConnection.newGroupList(groupName, groupColor);

    _getGroupsLists();
    _getTasksListsFromGroup();
  }

  void deleteGroup(String groupListID) {
    List<String?> groupListTaskListsID =
        groupListDBConnection.getListsFromGroup(groupListID);

    for (var x in groupListTaskListsID) {
      List<String?> listTasks = taskListDBConnection.getTasks(x ?? "");
      for (var y in listTasks) {
        taskDBConnection.deleteTask(y ?? "");
      }
      taskListDBConnection.deleteTaskList(x ?? "");
    }

    groupListDBConnection.deleteGroupList(groupListID);
    _getGroupsLists();
    _getTasksListsFromGroup();
  }
}
